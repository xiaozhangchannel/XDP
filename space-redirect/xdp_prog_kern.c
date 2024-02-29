/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <string.h>


#include "common_kern_user.h" 
#include "../common/parsing_helpers.h"


#ifndef memcpy
 #define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif


struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__type(key, __u32);
	__type(value, struct datarec);
	__uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_HASH);
	__type(key, __u16);
	__type(value, struct rules_coon_map);
	__uint(max_entries, MAX_RULES);
} rules_maps SEC(".maps");



static __always_inline
__u32 xdp_stats_record_action(struct xdp_md *ctx, __u32 action)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data     = (void *)(long)ctx->data;

	if (action >= XDP_ACTION_MAX)
		return XDP_ABORTED;

	/* Lookup in kernel BPF-side return pointer to actual data record */
	struct datarec *rec = bpf_map_lookup_elem(&xdp_stats_map, &action);
	if (!rec)
		return XDP_ABORTED;

	/* Calculate packet length */
	__u64 bytes = data_end - data;

	/* BPF_MAP_TYPE_PERCPU_ARRAY returns a data record specific to current
	 * CPU and XDP hooks runs under Softirq, which makes it safe to update
	 * without atomic operations.
	 */
	rec->rx_packets++;
	rec->rx_bytes += bytes;

	return action;
}


/*
* Description: Computes ip difference
* Parameters: Takes in pointer to ip header and the ip header size
* Returns: `u16`, new checksum
*/
static __always_inline __u16 ip_checksum(struct iphdr *ipHdr, int ipHdrSize)
{
    unsigned long csum = 0;

    csum = bpf_csum_diff(0, 0, (void *)ipHdr, ipHdrSize, 0);
    csum = (csum & 0xFFFF) + (csum >> 16);
    csum = (csum & 0xFFFF) + (csum >> 16);

    return ~csum;
}


/*
* Description: Computes tcp checksum difference
* Parameters: 1s complement of old checksum, the new tcp hdr, the old tcp hdr
* Returns: `u16`, new checksum
*/
static __always_inline __u16 tcp_checksum(struct tcphdr *tcpHdr, int tcpHdrSize)
{
    unsigned long csum = 0;

    csum = bpf_csum_diff(0, 0, (void *)tcpHdr, tcpHdrSize, 0);
    csum = (csum & 0xFFFF) + (csum >> 16);
    csum = (csum & 0xFFFF) + (csum >> 16);

    return ~csum;
}

//udp
static __always_inline __u16 udp_checksum(struct udphdr *udpHdr, int udpHdrSize)
{
    unsigned long csum = 0;

    csum = bpf_csum_diff(0, 0, (void *)udpHdr, udpHdrSize, 0);
    csum = (csum & 0xFFFF) + (csum >> 16);
    csum = (csum & 0xFFFF) + (csum >> 16);

    return ~csum;
}


static __always_inline
int mac_match(const __u8 *conn_addr, const __u8 *rule_mac) {
    // 直接比较MAC地址
	if( (memcmp(rule_mac, "\x00\x00\x00\x00\x00\x00", ETH_ALEN) == 0) || (memcmp(conn_addr, rule_mac, 6) == 0) ) //0 , match all
		return 1;
	return 0;
}


static __always_inline
int ipv4_match(__u32 conn_addr, __u32 rule_addr) {
    // 直接比较IPv4地址和网络地址
	if( (!rule_addr) || (conn_addr == rule_addr) ) //0 , match all
		return 1;
	return 0;
}


static __always_inline
int port_match(__u16 conn_port, __u16 rule_port){
	if( (!rule_port) || (rule_port == conn_port) ) //0 , match all
		return 1;
	return 0;
}


static int match_rules_loop(__u32 index, void *ctx)
{
	struct rules_coon_map *p_ctx = (struct rules_coon_map *)ctx;


	struct rules_coon_map *p_r = bpf_map_lookup_elem(&rules_maps, &index);
	if(!p_r){
		return 1; //out of range
	}
	

	if( mac_match(p_ctx->smac, p_r->smac) &&
		mac_match(p_ctx->dmac, p_r->dmac) &&
		ipv4_match(p_ctx->saddr, p_r->saddr) && 
		ipv4_match(p_ctx->daddr, p_r->daddr) &&
		port_match(p_ctx->sport, p_r->sport) &&
		port_match(p_ctx->dport, p_r->dport) ) 
	{
	
		memcpy(p_ctx->rmac, p_r->rmac, ETH_ALEN);
		p_ctx->raddr = p_r->raddr;
		p_ctx->rport = p_r->rport;

		/*
		bpf_printk("MAC: %02x:%02x:%02x:%02x:%02x:%02x", 
           p_ctx->rmac[0], p_ctx->rmac[1], p_ctx->rmac[2],
           p_ctx->rmac[3], p_ctx->rmac[4], p_ctx->rmac[5]);
		
		bpf_printk("IP: %u.%u.%u.%u", 
           p_ctx->raddr & 0xFF, (p_ctx->raddr >> 8) & 0xFF,
           (p_ctx->raddr >> 16) & 0xFF, (p_ctx->raddr >> 24) & 0xFF);

		bpf_printk("Port: %u", p_ctx->rport);
		*/
		


		return 1;
	}


	return 1;
}

static __always_inline 
struct coon_redirect match_rules(struct rules_coon_map *conn)
{
	struct rules_coon_map *ctx = conn;
	struct coon_redirect coon_r;
	//bpf_loop就是代替for的功能也是从0开始。
	//long bpf_loop(u32 iterations, long (*loop_fn)(u32 index, void *ctx),void *ctx, u64 flags);
	//bpf_loop() 通过接收一个 static 函数 loop_fn() 和 iterations，可让 loop_fn 执行 iterations 次。
	//其中，loop_fn() 中的 index 代表当前迭代的 index，ctx 是一个指向栈的值，而 flags 当前阶段总为 0。
	bpf_loop(MAX_RULES, match_rules_loop, ctx, 0);

	memcpy(coon_r.rmac, ctx->rmac, ETH_ALEN);
    coon_r.raddr = conn->raddr;
    coon_r.rport = conn->rport;
	
	/*
	bpf_printk("MAC: %02x:%02x:%02x:%02x:%02x:%02x", 
           coon_r.rmac[0], coon_r.rmac[1], coon_r.rmac[2],
           coon_r.rmac[3], coon_r.rmac[4], coon_r.rmac[5]);

	bpf_printk("IP: %u.%u.%u.%u", 
           coon_r.raddr & 0xFF, (coon_r.raddr >> 8) & 0xFF,
           (coon_r.raddr >> 16) & 0xFF, (coon_r.raddr >> 24) & 0xFF);

	bpf_printk("Port: %u", coon_r.rport);
	*/
	

	return coon_r;
}


SEC("xdp")
int xdp_entry(struct xdp_md *ctx)
{
	xdp_act action = XDP_PASS; 
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct hdr_cursor nh;
	int nh_type; //next header type
	struct ethhdr *eth;
	struct iphdr *iph;
	struct tcphdr *tcph; 
	struct udphdr *udph;
	struct coon_redirect coon_r;
	struct rules_coon_map coon = {.smac = {0}, .dmac = {0}, .rmac = {0}, .saddr = 0, .daddr = 0, .raddr = 0, .sport = 0, .dport = 0, .rport = 0};

	nh.pos = data;
	
	nh_type = parse_ethhdr(&nh, data_end, &eth);

	if(nh_type < 0)
		goto out;

	memcpy(coon.smac, eth->h_source, ETH_ALEN);
	memcpy(coon.dmac, eth->h_dest, ETH_ALEN);

	if (nh_type == bpf_htons(ETH_P_IP)) { 

		nh_type = parse_iphdr(&nh, data_end, &iph);

		if(nh_type < 0)
			goto out;
		
		coon.saddr = bpf_ntohl(iph -> saddr);
		coon.daddr = bpf_ntohl(iph -> daddr);

		if (nh_type == IPPROTO_TCP) {
			if(parse_tcphdr(&nh, data_end, &tcph) < 0)
				goto out;
			
			coon.sport = bpf_ntohs(tcph -> source);
			coon.dport = bpf_ntohs(tcph -> dest);

			coon_r = match_rules(&coon);

			//修改头部
			memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
        	memcpy(eth->h_dest, coon_r.rmac, ETH_ALEN);

			iph->saddr = iph->daddr;
        	iph->daddr = coon_r.raddr;

			tcph->dest = coon_r.rport;

			tcph->check = 0;
        	tcph->check = tcp_checksum(tcph, sizeof(struct tcphdr));

			iph->check = 0;
        	iph->check = ip_checksum(iph, sizeof(struct iphdr));

			action = XDP_REDIRECT;
			goto out;
			
		} 
		else if(nh_type == IPPROTO_UDP){
			if(parse_udphdr(&nh, data_end, &udph) < 0){
				goto out;
			}
			coon.sport = bpf_ntohs(udph -> source);
			coon.dport = bpf_ntohs(udph -> dest);

			coon_r = match_rules(&coon);

			//修改头部
			memcpy(eth->h_source, eth->h_dest, ETH_ALEN);
        	memcpy(eth->h_dest, coon_r.rmac, ETH_ALEN);

			iph->saddr = iph->daddr;
        	iph->daddr = coon_r.raddr;

			udph->dest = coon_r.rport;

			udph->check = 0;
        	udph->check = udp_checksum(udph, sizeof(struct udphdr));

			iph->check = 0;
        	iph->check = ip_checksum(iph, sizeof(struct iphdr));

			action = XDP_REDIRECT;
			goto out;

		}
		else {
			goto out;
		}
		
		
	} else {
		goto out;
	}
	
		
out:
	return xdp_stats_record_action(ctx, action);
}

char _license[] SEC("license") = "GPL";

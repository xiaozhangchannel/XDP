/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>

#include "common_kern_user.h" 
#include "../common/parsing_helpers.h"

struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__type(key, __u32);
	__type(value, struct datarec);
	__uint(max_entries, XDP_ACTION_MAX);
} xdp_stats_map SEC(".maps");


// 辅助函数，用于记录 XDP 操作统计信息
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

SEC("xdp")
int xdp_entry(struct xdp_md *ctx) {
	__u32 action = XDP_PASS; 
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct hdr_cursor nh;
	int nh_type; //next header type
	struct ethhdr *eth;
	struct iphdr *iph;
	struct tcphdr *tcph; 
	struct udphdr *udph;

    // 定义IPv4连接关键信息
	struct conn_ipv4_key conn_k = {.saddr = 0, .daddr = 0, .sport = 0, .dport = 0, .proto = 0, .tcp_state = 0};

    nh.pos = data;
	
	// 如果下一个头部类型为IPv4
	nh_type = parse_ethhdr(&nh, data_end, &eth);

	if(nh_type < 0)
		goto out;

	if (nh_type == bpf_htons(ETH_P_IP)) { 

        nh_type = parse_iphdr(&nh, data_end, &iph);

		if(nh_type < 0)
			goto out;
		
		conn_k.saddr = bpf_ntohl(iph -> saddr);
		conn_k.daddr = bpf_ntohl(iph -> daddr);
		conn_k.proto = nh_type;

        // 如果下一个头部类型为TCP
		if (nh_type == IPPROTO_TCP) {
			if(parse_tcphdr(&nh, data_end, &tcph) < 0)
				goto out;
			
			// 获取TCP连接信息
			conn_k.sport = bpf_ntohs(tcph -> source);
			conn_k.dport = bpf_ntohs(tcph -> dest);

            // 如果TCP报文是SYN并且不是ACK，则表示新的连接项
            if(tcph->syn && !tcph->ack){
                conn_k.tcp_state = TCP_S_SYN_SENT;
				goto out_tcp_conn;
            }

            // 收到了SYN和ACK
            if(tcph->syn && tcph->ack){
				conn_k.tcp_state = TCP_S_SYN_RECV;
				goto out_tcp_conn;
			}

            // 收到了ACK
            if(tcph->ack){
                conn_k.tcp_state = TCP_S_ESTABLISHED;
				goto out_tcp_conn;
            }

            // 收到了FIN并且不是ACK
            if(tcph->fin && !tcph->ack){
                conn_k.tcp_state = TCP_S_FIN_WAIT1;
				goto out_tcp_conn;
            }

            // 收到了FIN和ACK
            if(tcph->fin && tcph->ack){
                 // Check for CLOSE_WAIT or FIN_WAIT2
                if (tcph->rst) {
                    conn_k.tcp_state = TCP_S_CLOSE;
					goto out_tcp_conn;
                } else if (tcph->ack && !tcph->syn) {
                    // FIN_WAIT2
                    conn_k.tcp_state = TCP_S_FIN_WAIT2;
					goto out_tcp_conn;
                } else {
                    // CLOSE_WAIT
                    conn_k.tcp_state = TCP_S_CLOSE_WAIT;
					goto out_tcp_conn;
                }
            }

            if (!tcph->ack && !tcph->syn && !tcph->fin) {
                // Listen or other states
                conn_k.tcp_state = LISTEN_or_OTHER_STATE;
				goto out_tcp_conn;
            }

            const char *tcp_state_str;

			// 根据连接状态设置对应的字符串
			out_tcp_conn:
                // 根据连接状态打印日志
				switch(conn_k.tcp_state) {
					case TCP_S_SYN_SENT:
						tcp_state_str = "SYN_SENT";
						break;
					case TCP_S_SYN_RECV:
						tcp_state_str = "SYN_RECV";
						break;
					case TCP_S_ESTABLISHED:
						tcp_state_str = "ESTABLISHED";
						break;
					case TCP_S_FIN_WAIT1:
						tcp_state_str = "FIN_WAIT1";
						break;
					case TCP_S_FIN_WAIT2:
						tcp_state_str = "FIN_WAIT2";
						break;
					case TCP_S_CLOSE_WAIT:
						tcp_state_str = "CLOSE_WAIT";
						break;
					case TCP_S_CLOSE:
						tcp_state_str = "CLOSE";
						break;
					default:
						tcp_state_str = "";
				}
			bpf_printk("conn(%u:%u->%u:%u),state:%s,rid:%d",conn_k.saddr, conn_k.sport, conn_k.daddr, conn_k.dport, tcp_state_str);				
			goto out;
           
    
        }
        else if(nh_type == IPPROTO_UDP){
                // 如果是UDP包，解析UDP头部并获取端口信息
                if(parse_udphdr(&nh, data_end, &udph) < 0){
                    goto out;
                }
                conn_k.sport = bpf_ntohs(udph -> source);
                conn_k.dport = bpf_ntohs(udph -> dest);
        
        
        }

        #ifdef DEBUG_PRINT_EVERY
        // 打印除SSH协议以外的所有连接信息
        if(conn.dport != 22)
            bpf_printk("conn(%u:%u to %u:%u)", conn.saddr, conn.sport, conn.daddr, conn.dport);
        #endif

    }

out:
	return xdp_stats_record_action(ctx, action);

}

char _license[] SEC("license") = "GPL";
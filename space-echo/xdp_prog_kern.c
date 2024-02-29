/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>

// The parsing helper functions from the packet01 lesson have moved here
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"

/* Defines xdp_stats_map */
#include "../common/xdp_stats_kern_user.h"
#include "../common/xdp_stats_kern.h"

//便于复制
#ifndef memcpy
#define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif


// 辅助函数：将32位校验和折叠为16位值
static __always_inline __u16 csum_fold_helper(__u32 csum)
{
	// 定义一个32位整数变量 sum
	__u32 sum;

	// 将 csum 的高16位和低16位相加
	sum = (csum >> 16) + (csum & 0xffff);

	// 将 sum 的高16位和低16位相加
	sum += (sum >> 16);

	// 对 sum 取反，得到最终的16位折叠检验和值
	return ~sum;
}

//这个函数的目的是在修改 ICMP 报文时，更新 ICMP 头部的检验和，以保持 ICMP 报文的完整性。
/*
__u16 seed,: 函数接受一个 seed 参数，该参数是一个 16 位整数，用于初始化计算检验和的种子值。
struct icmphdr_common *icmphdr_new,: 接受一个指向新 ICMP 头部结构体的指针。
struct icmphdr_common *icmphdr_old): 接受一个指向旧 ICMP 头部结构体的指针。
*/
static __always_inline __u16 icmp_checksum_diff(
		__u16 seed,
		struct icmphdr_common *icmphdr_new,
		struct icmphdr_common *icmphdr_old)
{
	//定义一个 32 位整数 csum 用于保存计算的检验和值，并初始化 size 为 ICMP 头部结构体的大小。
	__u32 csum, size = sizeof(struct icmphdr_common);

	//使用 bpf_csum_diff 函数计算两个 ICMP 头部结构体的检验和差异。
	csum = bpf_csum_diff((__be32 *)icmphdr_old, size, (__be32 *)icmphdr_new, size, seed);
	//返回通过 csum_fold_helper 函数折叠后的 16 位检验和值。
	return csum_fold_helper(csum);
}


//该程序用于处理 ICMP Echo 请求并生成对应的 Echo Reply。
SEC("xdp_icmp_echo")
int xdp_icmp_echo_func(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct hdr_cursor nh;
	struct ethhdr *eth;
	int eth_type;
	int ip_type;
	int icmp_type;
	struct iphdr *iphdr;
	struct ipv6hdr *ipv6hdr;
	// 定义 ICMP 报文类型和旧的校验和值
	__u16 echo_reply, old_csum;
	// 定义 ICMP 头指针和保存旧的 ICMP 头的变量
	struct icmphdr_common *icmphdr;
	struct icmphdr_common icmphdr_old;
	__u32 action = XDP_PASS;

	/* These keep track of the next header type and iterator pointer */
	nh.pos = data;

	/* Parse Ethernet and IP/IPv6 headers */
	eth_type = parse_ethhdr(&nh, data_end, &eth);
	if (eth_type == bpf_htons(ETH_P_IP)) {
		ip_type = parse_iphdr(&nh, data_end, &iphdr);
		if (ip_type != IPPROTO_ICMP)
			goto out;
	} else if (eth_type == bpf_htons(ETH_P_IPV6)) {
		ip_type = parse_ip6hdr(&nh, data_end, &ipv6hdr);
		if (ip_type != IPPROTO_ICMPV6)
			goto out;
	} else {
		// 如果不是 IPv4 或 IPv6 数据包，直接跳过
		goto out;
	}

	icmp_type = parse_icmphdr_common(&nh, data_end, &icmphdr);
	// 如果是 IPv4 数据包且是 ICMP Echo 请求
	if (eth_type == bpf_htons(ETH_P_IP) && icmp_type == ICMP_ECHO) {
		/* Swap IP source and destination */
		swap_src_dst_ipv4(iphdr);
		// 设置 ICMP 类型为 Echo Reply
		echo_reply = ICMP_ECHOREPLY;
		// 如果是 IPv6 数据包且是 ICMPv6 Echo 请求
	} else if (eth_type == bpf_htons(ETH_P_IPV6)
		   && icmp_type == ICMPV6_ECHO_REQUEST) {
		/* Swap IPv6 source and destination */
		swap_src_dst_ipv6(ipv6hdr);
		// 设置 ICMPv6 类型为 Echo Reply
		echo_reply = ICMPV6_ECHO_REPLY;
	} else {
		// 如果不是期望的 ICMP Echo 请求，直接跳过
		goto out;
	}

	/* Swap Ethernet source and destination */
	swap_src_dst_mac(eth);


	// 修补数据包并更新校验和
	/* Patch the packet and update the checksum.*/
	// 保存原始的 ICMP 校验和值
	old_csum = icmphdr->cksum;
	// 将 ICMP 校验和字段置为 0（因为在计算新校验和时会重新计算）
	icmphdr->cksum = 0;
	// 复制原始 ICMP 头到 icmphdr_old 变量
	icmphdr_old = *icmphdr;
	// 修改 ICMP 类型为 Echo Reply（响应报文）
	icmphdr->type = echo_reply;
	// 计算新的 ICMP 校验和，使用 icmp_checksum_diff 函数
	icmphdr->cksum = icmp_checksum_diff(~old_csum, icmphdr, &icmphdr_old);

	action = XDP_TX;
	bpf_printk("ok");
out:
	return action;
}

char _license[] SEC("license") = "GPL";
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

#ifndef memcpy
#define memcpy(dest, src, n) __builtin_memcpy((dest), (src), (n))
#endif

/*
// 用于将网络接口的索引映射到另一个网络接口的索引。存储网络接口（或网卡）的映射关系。
struct {
	__uint(type, BPF_MAP_TYPE_DEVMAP);  // 映射类型为 DEVMAP，表示网络接口映射
	__type(key, int);                   // 键的类型是 int，即网络接口的索引
	__type(value, int);                 // 值的类型是 int，即目标网络接口的索引
	__uint(max_entries, 256);           // 映射最大条目数为 256
} tx_port SEC(".maps");
*/

// 用于存储以太网帧的源 MAC 地址与目标 MAC 地址之间的映射关系。用于实现网络流量的重定向或转发。
struct {
	__uint(type, BPF_MAP_TYPE_HASH);             // 映射类型为 HASH，表示哈希映射
	__type(key,  unsigned char[ETH_ALEN]);       // 键的类型是 ETH_ALEN 长度的无符号字符数组，即源 MAC 地址
	__type(value, unsigned char[ETH_ALEN]);      // 值的类型是 ETH_ALEN 长度的无符号字符数组，即目标 MAC 地址
	__uint(max_entries, 1);                      // 映射最大条目数为 1
} redirect_params SEC(".maps");

/* Solution to packet03/assignment-3 */
SEC("xdp_redirect_map")
int xdp_redirect_map_func(struct xdp_md *ctx)
{
	void *data_end = (void *)(long)ctx->data_end;
	void *data = (void *)(long)ctx->data;
	struct hdr_cursor nh;
	struct ethhdr *eth;
	int eth_type;
	int action = XDP_PASS;
	unsigned char *dst;
	unsigned ifindex = 0;//初始化网络接口

	/* These keep track of the next header type and iterator pointer */
	nh.pos = data;

	/* Parse Ethernet and IP/IPv6 headers */
	eth_type = parse_ethhdr(&nh, data_end, &eth);
	if (eth_type == -1)
		goto out;

	/* 查找对应，mac */
	dst = bpf_map_lookup_elem(&redirect_params, eth->h_source);
	if (!dst)
		goto out;

	/* 设置正确的目标地址 */
	memcpy(eth->h_dest, dst, ETH_ALEN);
	//action = bpf_redirect_map(&tx_port, 0, 0);

	action = bpf_redirect(ifindex, 0);


out:
	return xdp_stats_record_action(ctx, action);
}
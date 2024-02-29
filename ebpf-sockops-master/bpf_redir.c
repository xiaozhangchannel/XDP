#include <stdint.h>
#include <stdio.h>

#include <linux/bpf.h>
#include <sys/socket.h>

#include "bpf_sockops.h"

// 定义一个 BPF 程序，用于重定向套接字消息
__section("sk_msg")
int bpf_redir(struct sk_msg_md *msg)
{
	//BPF_F_INGRESS是一种标志，用于指示数据包处理方向。在给定的上下文中，BPF_F_INGRESS可能表示数据包将进入协议栈，即数据包是传入的。
    __u64 flags = BPF_F_INGRESS; // 设置标志为 BPF_F_INGRESS
	
    struct sock_key key = {}; // 定义一个套接字关键字结构体

    sk_msg_extract4_key(msg, &key); // 提取套接字消息的 IPv4 关键字信息

    // 检查源或目标 IP 地址是否是本地主机
    if (key.dip4 == loopback_ip || key.sip4 == loopback_ip) {
        // 检查源或目标端口是否是 SERVER_PORT
        if (key.dport == bpf_htons(SERVER_PORT) || key.sport == bpf_htons(SERVER_PORT)) {
            // 执行消息重定向到套接字操作哈希表
            msg_redirect_hash(msg, &sock_ops_map, &key, flags);
        }
    }

    return SK_PASS; // 返回 SK_PASS，表示套接字消息应该被传递
}

BPF_LICENSE("GPL"); // 设置 BPF 程序的许可证为 GPL
int _version __section("version") = 1; // 定义 BPF 程序的版本号为 1

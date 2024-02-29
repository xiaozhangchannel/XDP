#include <linux/bpf.h>
#include <linux/bpf_common.h>
#include <sys/socket.h>

#include "bpf_sockops.h"


// 内联函数，用于处理 IPv4 套接字操
static inline void bpf_sock_ops_ipv4(struct bpf_sock_ops *skops)
{
	struct sock_key key = {};
	sk_extract4_key(skops, &key);
	// 如果源地址或目标地址是回环地址，并且端口是 SERVER_PORT，则更新套接字哈希表
	if (key.dip4 == loopback_ip || key.sip4 == loopback_ip ) {
		if (key.dport == bpf_htons(SERVER_PORT) || key.sport == bpf_htons(SERVER_PORT)) {
			// 更新套接字哈希表
			int ret = sock_hash_update(skops, &sock_ops_map, &key, BPF_NOEXIST);
			// 打印日志信息
			printk("<<< ipv4 op = %d, port %d --> %d\n", skops->op, key.sport, key.dport);
			if (ret != 0)
			// 打印错误信息
				printk("*** FAILED %d ***\n", ret);
		}
	}
}


// 内联函数，用于处理 IPv6 套接字操作
static inline void bpf_sock_ops_ipv6(struct bpf_sock_ops *skops)
{
        if (skops->remote_ip4)
                bpf_sock_ops_ipv4(skops);
}


__section("sockops")
int bpf_sockmap(struct bpf_sock_ops *skops)
{
	__u32 family, op;

	// 获取套接字家族
	family = skops->family;
	// 获取套接字操作码
	op = skops->op;

	//printk("<<< op %d, port = %d --> %d\n", op, skops->local_port, skops->remote_port);
	// 根据套接字操作码进行处理
	switch (op) {
        case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: // 被动建连
        case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB: // 主动建连
		if (family == AF_INET6)
                        bpf_sock_ops_ipv6(skops);
                else if (family == AF_INET) // AF_INET
                        bpf_sock_ops_ipv4(skops); // 将 socket 信息记录到到 sockmap
                break;
        default:
                break;
        }
	return 0;
}

BPF_LICENSE("GPL");
int _version __section("version") = 1;
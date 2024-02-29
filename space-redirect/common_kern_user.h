/* This common_kern_user.h is used by kernel side BPF-progs and
 * userspace programs, for sharing common struct's and DEFINEs.
 */
#ifndef __COMMON_KERN_USER_H
#define __COMMON_KERN_USER_H

#include <linux/bpf.h>
#include <linux/if_ether.h>

typedef __u32 xdp_act;

#define ALERT_ERR_STR "[XACL] ERROR:"



#define MAX_RULES 256



struct datarec {
	__u64 rx_packets;
	__u64 rx_bytes;
};



struct rules_coon_map {
	__u8 smac[ETH_ALEN];
	__u8 dmac[ETH_ALEN];
	__u8 rmac[ETH_ALEN];
	__u32 saddr;
	__u32 daddr;
	__u32 raddr;
	__u16 sport;
	__u16 dport;
	__u16 rport;
};

struct coon_redirect {
	__u8 rmac[ETH_ALEN];
	__u32 raddr;
	__u16 rport;
};

#ifndef XDP_ACTION_MAX
#define XDP_ACTION_MAX (XDP_REDIRECT + 1)
#endif

#endif /* __COMMON_KERN_USER_H */

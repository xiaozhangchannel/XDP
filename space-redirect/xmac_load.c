#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <getopt.h>
#include <stdbool.h>

#include <locale.h>
#include <unistd.h>
#include <time.h>

#include <bpf/bpf.h>
#include <bpf/libbpf.h>

#include <net/if.h>
#include <linux/if_ether.h>
#include <linux/if_link.h> /* depend on kernel-headers installed */

#include "../common/common_params.h"
#include "../common/common_user_bpf_xdp.h"
#include "../common/common_libbpf.h"

#include "../common/xdp_stats_kern_user.h"



static int write_iface_params(int map_fd, unsigned char *src, unsigned char *dest)
{
	if (bpf_map_update_elem(map_fd, src, dest, 0) < 0) {
		fprintf(stderr,
			"WARN: Failed to update bpf map file: err(%d):%s\n",
			errno, strerror(errno));
		return -1;
	}

	printf("forward: %02x:%02x:%02x:%02x:%02x:%02x -> %02x:%02x:%02x:%02x:%02x:%02x\n",
			src[0], src[1], src[2], src[3], src[4], src[5],
			dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]
	      );

	return 0;
}

#ifndef PATH_MAX
#define PATH_MAX 4096
#endif

const char *pin_basedir =  "/sys/fs/bpf";

int main(int argc, char **argv)
{

	int map_fd;
	char pin_dir[PATH_MAX];
	unsigned char src[ETH_ALEN] = {0x22, 0x0c, 0x29, 0xab, 0x88, 0xa2};
	unsigned char dest[ETH_ALEN] = {0x00, 0x0c, 0x29, 0xdd, 0x17, 0x2c};

	/* Cmdline options can change progname */

	/* Open the tx_port map corresponding to the cfg.ifname interface */
	/*
	map_fd = open_bpf_map_file(pin_dir, "tx_port", NULL);
	if (map_fd < 0) {
		return EXIT_FAIL_BPF;
	}
	*/

	printf("map dir: %s\n", pin_dir);

	/* setup a virtual port for the static redirect */
	


		/* Open the redirect_params map */
	map_fd = open_bpf_map_file(pin_dir, "redirect_params", NULL);
	if (map_fd < 0) {
		return EXIT_FAIL_BPF;
	}

		/* Setup the mapping containing MAC addresses */
	if (write_iface_params(map_fd, src, dest) < 0) {
		fprintf(stderr, "can't write iface params\n");
		return 1;
	}

    
	return EXIT_OK;
}



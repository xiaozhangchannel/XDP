#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <string.h>

#include <bpf/bpf.h>

//#include "map_common.h"
#include "map_common.c"
#include "common_kern_user.h"

char *ifname;

int rules_maps;

int print_usage(int id){
    switch(id){
        case 0:
            fprintf(stderr, "Usage: <command> <arg1> <arg2>\n");
            break;
        default:
            break;
    };

    return 0;
}

int load_bpf_map(){
    rules_maps = open_map(ifname, "rules_maps");
    if(rules_maps < 0){
        fprintf(stderr, "load bpf map error,check device name\n");
        return -1;
    }

    return 0;
}


static __u32 ip_to_u32(__u8 *ip_u8) {
    __u32 ip_u32 = 0;
    ip_u32 = (ip_u8[0]<<24) | (ip_u8[1]<<16) | (ip_u8[2]<<8) | (ip_u8[3]);
    //printf("%hhu.%hhu.%hhu.%hhu,%u\n",ip_u8[0],ip_u8[1],ip_u8[2],ip_u8[3],ip_u32);
    return ip_u32;
}


int clear_map(){
    __u16 keys[MAX_RULES];
    for(int i=0; i<MAX_RULES; i++){
        keys[i] = i;
    }

    DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
		.elem_flags = 0,
		.flags = 0,
	);

    __u32 count = MAX_RULES;

    bpf_map_delete_batch(rules_maps, &keys, &count, &opts);

    return count;
}

int load_handler(int argc, char *argv[]){
    if(argc < 1){
        print_usage(1);
        return EXIT_FAILURE;
    }

    char *path = argv[0];
    printf("loading config file:%s\n",path);
    
    FILE *file = fopen(path, "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    __u16 keys[MAX_RULES];
    struct rules_coon_map rules[MAX_RULES];

    __u32 i = 0;
    keys[i] = 0;
    char line[256];
    while (fgets(line, sizeof(line), file) != NULL) {
        line[strcspn(line, "\n")] = '\0';

        __u8 smac[6];
        __u8 dmac[6];
        __u8 rmac[6];
        __u8 saddr[4];
        __u8 daddr[4];
        __u8 raddr[4];
        //mac,ip,端口。源，目的，转发地
        sscanf(line, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu.%hhu.%hhu.%hhu %hu \
                        %hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu.%hhu.%hhu.%hhu %hu \
                        %hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu.%hhu.%hhu.%hhu %hu" ,
           &smac[0], &smac[1], &smac[2], &smac[3], &smac[4], &smac[5], 
           &saddr[0], &saddr[1] ,&saddr[2] ,&saddr[3], 
           &rules[i].sport,
           &dmac[0], &dmac[1], &dmac[2], &dmac[3], &dmac[4], &dmac[5], 
           &daddr[0] ,&daddr[1] ,&daddr[2] ,&daddr[3], 
           &rules[i].dport,
           &rmac[0], &rmac[1], &rmac[2], &rmac[3], &rmac[4], &rmac[5],
           &raddr[0] ,&raddr[1] ,&raddr[2] ,&raddr[3], 
           &rules[i].rport);


        memcpy(rules[i].smac, smac, ETH_ALEN);
        memcpy(rules[i].dmac, dmac, ETH_ALEN);
        memcpy(rules[i].rmac, rmac, ETH_ALEN);

        rules[i].saddr = ip_to_u32(saddr);
        rules[i].daddr = ip_to_u32(daddr);
        rules[i].raddr = ip_to_u32(raddr);


        keys[i] = i;
        i += 1;
    }
    printf("%d rules loaded\n",i);

    DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
		.elem_flags = 0,
		.flags = 0,
	);
    clear_map();
    // 使用 libbpf 库中的 bpf_map_update_batch 函数批量更新 BPF 映射。
    // 这个函数用于一次性更新多个键值对，以提高效率。

    // rules_ipv4_map: 要更新的 BPF 映射的文件描述符（FD）。
    // keys: 包含要更新的键（key）的数组。
    // rules: 包含要更新的值的数组。
    // &i: 这是一个指向整数的指针，表示要更新的键值对的数量。在调用函数后，该整数将包含实际更新的键值对数量。
    // &opts: 用于配置更新选项的结构体，这里是通过 DECLARE_LIBBPF_OPTS 宏声明并初始化的。

    // 在这里，代码中的 bpf_map_update_batch 操作的目的是将多个键值对一次性更新到 BPF 映射中。
    // 这样可以通过一次系统调用来完成多个更新操作，提高了效率。

    bpf_map_update_batch(rules_maps, keys, rules, &i, &opts);

    return 0;   
}

int clear_handler(int argc, char *argv[]){
    int ret = clear_map();
    printf("%d rules are cleared\n", ret-1);
    return 0;
}


int main(int argc, char *argv[]){ //xacladm load enp1s0 ./conf.d/ipv4.conf
    int ret = 0;

    if(argc < 3){
        print_usage(0);
        return EXIT_FAILURE;
    }

    char *command = argv[1];
    ifname = argv[2];

    load_bpf_map();
    if (strcmp(command, "load") == 0) {
        ret = load_handler(argc - 2, argv + 3);
    } else if (strcmp(command, "clear") == 0) {
        ret = clear_handler(argc - 2, argv + 3);
    } else {
        fprintf(stderr, "Unknown command: %s\n", command);
        print_usage(0);
        return EXIT_FAILURE;
    }

    return ret;
}
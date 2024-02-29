## Usage

- Setup dependencies

```
sudo apt update
sudo apt install clang llvm libelf-dev libpcap-dev build-essential linux-headers-$(uname -r) linux-tools-common linux-tools-generic libc6-dev-i386 libxdp-dev xdp-tools
```

- Compile the project

```
./configure
make
```

- Attach XDP program to your interface

```
sudo ./xacl_core/xdp_loader -d **YOUR_DEV_NAME**
```

> WARNING: XDP only works on RX path, so make sure your traffic passing through RX path
> if you want to test this program in Docker env, you can change ARP table in the docker contaioner

- result:

```
sudo cat /sys/kernel/debug/tracing/trace_pipe
```


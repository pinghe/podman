FROM alpine

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN info(){ printf '\x1B[32m--\n%s\n--\n\x1B[0m' "$*"; } && \
    pwd && \
    whoami && \
    apk update && \
    apk upgrade && \
    apk add --no-cache tzdata coreutils nodejs git curl wget bash iptables util-linux shadow containerd podman && \
    ln -s $(which podman) /usr/local/bin/docker && \
    modprobe tun && \
    # modprobe fuse && \
    # rc-service cgroups start && \
    # rc-update add cgroups && \
    # service cgroups start && \
     # apparmor 
    # tee /etc/containers/containers.conf <<EOF
    #     [engine]
    #     cgroup_manager = "cgroupfs"
    #     events_logger="file"
    #     [security]
    #     label=false
    #     apparmor_profile=""
    #     EOF && \
    # /bin/bash -c 'echo [engine] && echo cgroup_manager = "cgroupfs" && echo events_logger = "file" && echo [security] && echo label = false && echo apparmor_profile = ""' | tee /etc/containers/containers.conf && \
    # /bin/bash -c 'echo [security] && echo label = false && echo apparmor_profile = ""' | tee /etc/containers/containers.conf && \
    sed -i 's/driver = "overlay"/driver = "vfs"/' /etc/containers/storage.conf && \
    cat /etc/containers/containers.conf && \
    # service apparmor enable && \
    # aa-status && \
    echo 1000:100000:200000 >> /etc/subuid && \
    echo 1000:100000:200000 >> /etc/subgid && \
    echo $(id -un):1:999 >> /etc/subuid && \
    echo $(id -un):1001:64535 >> /etc/subuid && \
    echo $(id -gn):1:999 >> /etc/subgid && \
    echo $(id -gn):1001:64535 >> /etc/subgid && \
    # sed -Ei 's!^profile podman /usr/bin/podman !profile podman /usr/{bin,local/bin}/podman !' /etc/apparmor.d/podman && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# RUN tee /etc/containers/containers.conf <<EOF
#     [engine]
#     cgroup_manager = "cgroupfs"
#     events_logger="file"
#     [security]
#     label=false
#     apparmor_profile=""
#     EOF
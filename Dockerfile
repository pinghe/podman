FROM ghcr.io/mgoltzsche/podman:5.5.1 AS prod

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN info(){ printf '\x1B[32m--\n%s\n--\n\x1B[0m' "$*"; } && \
    pwd && \
    whoami && \
    apk update && \
    apk upgrade && \
    apk add --no-cache tzdata coreutils containerd nodejs git curl wget bash iptables util-linux shadow apparmor && \
    # tee /etc/containers/containers.conf <<EOF
    #     [engine]
    #     cgroup_manager = "cgroupfs"
    #     events_logger="file"
    #     [security]
    #     label=false
    #     apparmor_profile=""
    #     EOF && \
    /bin/bash -c 'echo "[engine]" && echo "cgroup_manager = """cgroupfs"""" | tee /etc/containers/containers.conf && \
    cat /etc/containers/containers.conf && \
    # service apparmor enable && \
    # aa-status && \
    echo $(id -un):100000:200000 >> /etc/subuid && \
    echo $(id -gn):100000:200000 >> /etc/subgid && \
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
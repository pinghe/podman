FROM ghcr.io/mgoltzsche/podman:5.5.1 AS prod

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN info(){ printf '\x1B[32m--\n%s\n--\n\x1B[0m' "$*"; } && \
    pwd && \
    apk update && \
    apk upgrade && \
    apk add --no-cache tzdata coreutils nodejs git curl wget bash && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

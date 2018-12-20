FROM ubuntu:16.04

RUN apt-get update && \
    apt-get clean && apt-get -y update && apt-get install -y locales curl && \
    apt-get install -y php apache2 curl openvpn zip unzip bridge-utils && \
    apt-get install nano
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun

COPY tcp /etc/openvpn

EXPOSE 8888

CMD openvpn --config /etc/openvpn/Belgium.Brussels.TCP.ovpn
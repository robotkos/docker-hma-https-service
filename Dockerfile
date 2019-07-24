FROM ubuntu:18.04

RUN apt-get update && \
    apt-get clean && apt-get -y update && \
    apt-get install -y openvpn tinyproxy-bin iptables && \
    apt-get install nano && \
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN echo "nameserver 8.8.4.4" >> /etc/resolv.conf

COPY tcp /etc/openvpn
COPY tinyproxy /etc/tinyproxy
COPY opt /opt

#EXPOSE 3128

CMD tinyproxy && openvpn --config /etc/openvpn/Belgium.Brussels.TCP.ovpn --pull-filter ignore "ifconfig-ipv6" --pull-filter ignore "route-ipv6" --script-security 2 --up "/opt/openvpn-up.sh"

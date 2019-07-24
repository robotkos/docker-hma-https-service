#!/bin/sh

/sbin/ip route add 172.0.0.0/8 dev eth0
#Disable incoming connections from the VPN
/sbin/iptables -A INPUT -i tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A INPUT -i tun0 -j DROP


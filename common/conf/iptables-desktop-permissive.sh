#!/bin/sh
set -euo pipefail
trap pwd ERR

# export NET6=$(/run/current-system/sw/bin/route -n6 | grep "/64" | grep ^2 | cut -d ' ' -f 1)
export NET6=2a0b:5f04:16e:1200::/64

export ALL_IL_AN=ff01::1
export ALL_LL_AN=ff02::1
export ALL_DHCP=ff02::1:2
export AMPR_HOME=44.63.0.51/32
export AMPR_NET=44.0.0.0/8
export BCAST=192.168.1.255
export BCAST_ALL=255.255.255.255
export DHCP_CLIENT_PORT=68
export DHCP_SERVER_PORT=67
export DHCP6_CLIENT_PORT=546
export DHCP6_SERVER_PORT=547
export IPT=iptables-nft
export IP6T=ip6tables-nft
export LL6=fe80::/10
export LOCAL_8=127.0.0.0/8
export LOCAL_128=::1/128
export MULTICAST_4=224.0.0.0/4
export MULTICAST6_8=ff00::/8
export NET=192.168.1.0/24
export PRIVNET_8=10.0.0.0/8
export PRIVNET_12=172.16.0.0/12
export PRIVNET_16=192.168.0.0/16
export ROUTER=192.168.1.254
export ROUTER6=fe80::1
export SSDP=239.255.255.250
export SSDP6_LL=ff02::c
export SSDP6_SL=ff05::c
export ZERO=0.0.0.0

$IPT -F
$IP6T -F

## INPUT
$IPT -P INPUT DROP
$IP6T -P INPUT DROP

# SSH in
# $IPT -A INPUT -p tcp --dport 22 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 22 -j ACCEPT

# Web in
$IPT -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IP6T -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IPT -A INPUT -p tcp --dport 443 -j ACCEPT
$IPT -A INPUT -p udp --dport 443 -j ACCEPT # quic
$IP6T -A INPUT -p tcp --dport 443 -j ACCEPT
$IP6T -A INPUT -p udp --dport 443 -j ACCEPT # quic

# DNS in
# $IPT -A INPUT -p udp --dport 53 -j ACCEPT
# $IP6T -A INPUT -p udp --dport 53 -j ACCEPT

# SMTP in
# $IPT -A INPUT -p tcp --dport 25 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 25 -j ACCEPT

# SMTPS in
# $IPT -A INPUT -p tcp --dport 587 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 587 -j ACCEPT

# Sauer in
$IPT -A INPUT -p udp --dport 28785 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28785 -j ACCEPT
$IPT -A INPUT -p udp --dport 28784 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28784 -j ACCEPT
$IPT -A INPUT -p udp --dport 28786 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28786 -j ACCEPT

# Doomsday
$IPT -A INPUT -p udp --dport 13209 -j ACCEPT
$IP6T -A INPUT -p udp --dport 13209 -j ACCEPT
$IPT -A INPUT -p tcp --dport 13209 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 13209 -j ACCEPT

# Game server discovery?
$IPT -A INPUT -p udp -s $NET -d $BCAST_ALL -m multiport --dport 13210:13224 -j ACCEPT # --sport 29312

# Internal networks
$IPT -A INPUT -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT
$IPT -A INPUT -p tcp -s $PRIVNET_8 -d $PRIVNET_8 -j ACCEPT

# DHCP
$IPT -A INPUT -p udp -s $ZERO -d $BCAST_ALL --sport $DHCP_CLIENT_PORT --dport $DHCP_SERVER_PORT -j ACCEPT
$IPT -A INPUT -p udp -s $ROUTER -d $BCAST_ALL --sport $DHCP_SERVER_PORT --dport $DHCP_CLIENT_PORT -j ACCEPT
$IP6T -A INPUT -p udp -s $LL6 -d $LL6 --sport $DHCP6_SERVER_PORT --dport $DHCP6_CLIENT_PORT -j ACCEPT

# lo
$IPT -A INPUT -i lo -j ACCEPT
$IP6T -A INPUT -i lo -j ACCEPT

# BitTorrent
$IPT -A INPUT -p tcp -d $NET --dport 6881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp -d $NET --dport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp -d $NET --sport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --sport 6881 -j ACCEPT
# $IPT -A INPUT -p udp -d $NET --dport 6881 -j ACCEPT
# $IP6T -A INPUT -p udp -d $NET6 --dport 6881 -j ACCEPT

# aria2
$IPT -A INPUT -p tcp -d $NET -m multiport --dport 6881:6999 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 -m multiport --dport 6881:6999 -j ACCEPT
$IPT -A INPUT -p udp -d $NET -m multiport --dport 6881:6999 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 6881:6999 -j ACCEPT

# DHT
$IPT -A INPUT -p tcp -d $NET --dport 7881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 7881 -j ACCEPT
$IPT -A INPUT -p udp -d $NET --dport 7881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 7881 -j ACCEPT

# Tracker
$IPT -A INPUT -p tcp -d $NET --dport 8881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 8881 -j ACCEPT
$IPT -A INPUT -p udp -d $NET --dport 8881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 8881 -j ACCEPT

# Steam Client
$IPT -A INPUT -p tcp -d $NET --dport 27015 -j ACCEPT
$IPT -A INPUT -p udp -d $NET --dport 27015 -j ACCEPT
$IPT -A INPUT -p udp -d $NET -m multiport --dport 27031:27036 -j ACCEPT
$IPT -A INPUT -p tcp -d $NET --dport 27036 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 27015 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 27015 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 27031:27036 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 27036 -j ACCEPT

# FTP responses
$IPT -A INPUT -p tcp -d $NET --sport 20 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --sport 20 -j ACCEPT

# IGMP Multicast
$IPT -A INPUT -p igmp -s $NET -d $MULTICAST_4 -j ACCEPT
$IPT -A INPUT -p igmp -s $ZERO -d $MULTICAST_4 -j ACCEPT
$IP6T -A INPUT -p igmp -s $NET6 -d $MULTICAST6_8 -j ACCEPT

# mDNS
$IPT -A INPUT -p udp -s $NET -d $MULTICAST_4 --dport 5353 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $MULTICAST6_8 --dport 5353 -j ACCEPT

# DLNA (TODO related?)
$IPT -A INPUT -p udp -s $ROUTER -d $NET --sport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $ROUTER6 -d $NET6 --sport 1900 -j ACCEPT

# Plex
$IPT -A INPUT -p tcp -d $NET -m multiport --dport 32400,32401 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 -m multiport --dport 32400,32401 -j ACCEPT
$IPT -A INPUT -p tcp -d $NET --sport 443 -j ACCEPT # psh?
$IP6T -A INPUT -p tcp -d $NET6 --sport 443 -j ACCEPT # psh?

# Plex network discovery
$IPT -A INPUT -p udp -s $NET -d $BCAST -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_IL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_LL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA
$IPT -A INPUT -p udp -s $NET -d $SSDP --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_LL --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_SL --dport 1900 -j ACCEPT

# TV
$IPT -A INPUT -p udp -s $NET -d $SSDP --dport 15600 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_LL --dport 15600 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_SL --dport 15600 -j ACCEPT

# KDE Connect
$IPT -A INPUT -p tcp -s $NET -d $NET -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $NET6 -m multiport --dport 1714:1764 -j ACCEPT
$IPT -A INPUT -p udp -s $NET -d $NET -m multiport --dport 1714:1764 -j ACCEPT
$IPT -A INPUT -p udp -s $NET -d $BCAST_ALL -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $NET6 -m multiport --dport 1714:1764 -j ACCEPT

# KDE Connect (Scanning)
$IPT -A INPUT -p tcp -s $NET -d $BCAST -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $ALL_IL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $ALL_LL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IPT -A INPUT -p udp -s $NET -d $BCAST -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_IL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_LL_AN -m multiport --dport 1714:1764 -j ACCEPT

# Discord
$IPT -A INPUT -p udp -d $NET -m multiport --dport 50000:65535 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 50000:65535 -j ACCEPT

# all local for now
$IPT -A INPUT -s $NET -d $NET -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $NET6 -j ACCEPT
$IP6T -A INPUT -s $LL6 -j ACCEPT
$IP6T -A INPUT -d $LL6 -j ACCEPT

# SMB
$IPT -A INPUT -p tcp -s $NET -m multiport --dport 137,139,445,5357 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -m multiport --dport 137,139,445,5357 -j ACCEPT
$IPT -A INPUT -p udp -s $NET -m multiport --dport 3702 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -m multiport --dport 3702 -j ACCEPT

# and all local broadcast
$IPT -A INPUT -s $NET -d $BCAST -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $ALL_IL_AN -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $ALL_LL_AN -j ACCEPT

# all local on ham
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -j ACCEPT

$IPT -A INPUT -i waydroid0 -j ACCEPT

# except ssh/https/ircs
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -p tcp -m multiport --dport 22,443,6697 -j DROP

# ICMPv6 is more necessary than ICMPv4
$IP6T -A INPUT -p icmpv6 -j ACCEPT

# Invalid
$IPT -A INPUT -m conntrack --ctstate INVALID -j DROP
$IP6T -A INPUT -m conntrack --ctstate INVALID -j DROP

# Existing
$IPT -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A INPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
# $IPT -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4
# $IP6T -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4

$IPT -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"
$IP6T -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"

# Rest
$IPT -A INPUT -j DROP
$IP6T -A INPUT -j DROP


## FORWARD
$IPT -P FORWARD ACCEPT
$IP6T -P FORWARD ACCEPT

## OUTPUT
$IPT -P OUTPUT ACCEPT
$IP6T -P OUTPUT ACCEPT
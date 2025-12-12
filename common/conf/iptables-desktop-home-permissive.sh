#!/bin/sh
set -euo pipefail
trap pwd ERR

source ./common.sh
source ../private/net/.env

$IP4T -F
$IP6T -F

## INPUT
$IP4T -P INPUT DROP
$IP6T -P INPUT DROP

# SSH in
# $IP4T -A INPUT -p tcp --dport 22 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 22 -j ACCEPT

# Web in
$IP4T -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IP6T -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IP4T -A INPUT -p tcp --dport 443 -j ACCEPT
$IP4T -A INPUT -p udp --dport 443 -j ACCEPT # quic
$IP6T -A INPUT -p tcp --dport 443 -j ACCEPT
$IP6T -A INPUT -p udp --dport 443 -j ACCEPT # quic

# DNS in
# $IP4T -A INPUT -p udp --dport 53 -j ACCEPT
# $IP6T -A INPUT -p udp --dport 53 -j ACCEPT

# SMTP in
# $IP4T -A INPUT -p tcp --dport 25 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 25 -j ACCEPT

# SMTPS in
# $IP4T -A INPUT -p tcp --dport 587 -j ACCEPT
# $IP6T -A INPUT -p tcp --dport 587 -j ACCEPT

# Sauer in
$IP4T -A INPUT -p udp --dport 28785 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28785 -j ACCEPT
$IP4T -A INPUT -p udp --dport 28784 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28784 -j ACCEPT
$IP4T -A INPUT -p udp --dport 28786 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28786 -j ACCEPT

# Doomsday
$IP4T -A INPUT -p udp --dport 13209 -j ACCEPT
$IP6T -A INPUT -p udp --dport 13209 -j ACCEPT
$IP4T -A INPUT -p tcp --dport 13209 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 13209 -j ACCEPT

# Game server discovery?
$IP4T -A INPUT -p udp -s $NET4 -d $BCAST4_ALL -m multiport --dport 13210:13224 -j ACCEPT # --sport 29312

# Internal networks
$IP4T -A INPUT -p tcp -s $PRIVNET4_12 -d $PRIVNET4_12 -j ACCEPT
$IP4T -A INPUT -p tcp -s $PRIVNET4_8 -d $PRIVNET4_8 -j ACCEPT

# DHCP
$IP4T -A INPUT -p udp -s $NULL4 -d $BCAST4_ALL --sport $DHCP4_CLIENT_PORT --dport $DHCP4_SERVER_PORT -j ACCEPT
$IP4T -A INPUT -p udp -s $GATEWAY4 -d $BCAST4_ALL --sport $DHCP4_SERVER_PORT --dport $DHCP4_CLIENT_PORT -j ACCEPT
$IP6T -A INPUT -p udp -s $LL6 -d $LL6 --sport $DHCP6_SERVER_PORT --dport $DHCP6_CLIENT_PORT -j ACCEPT

# lo
$IP4T -A INPUT -i lo -j ACCEPT
$IP6T -A INPUT -i lo -j ACCEPT

# BitTorrent
$IP4T -A INPUT -p tcp -d $NET4 --dport 6881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 6881 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 --dport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 6881 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 --sport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --sport 6881 -j ACCEPT
# $IP4T -A INPUT -p udp -d $NET4 --dport 6881 -j ACCEPT
# $IP6T -A INPUT -p udp -d $NET6 --dport 6881 -j ACCEPT

# aria2
$IP4T -A INPUT -p tcp -d $NET4 -m multiport --dport 6881:6999 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 -m multiport --dport 6881:6999 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 -m multiport --dport 6881:6999 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 6881:6999 -j ACCEPT

# DHT
$IP4T -A INPUT -p tcp -d $NET4 --dport 7881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 7881 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 --dport 7881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 7881 -j ACCEPT

# Tracker
$IP4T -A INPUT -p tcp -d $NET4 --dport 8881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 8881 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 --dport 8881 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 8881 -j ACCEPT

# Steam Client
$IP4T -A INPUT -p tcp -d $NET4 --dport 27015 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 --dport 27015 -j ACCEPT
$IP4T -A INPUT -p udp -d $NET4 -m multiport --dport 27031:27036 -j ACCEPT
$IP4T -A INPUT -p tcp -d $NET4 --dport 27036 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 27015 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 --dport 27015 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 27031:27036 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --dport 27036 -j ACCEPT

# FTP responses
$IP4T -A INPUT -p tcp -d $NET4 --sport 20 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 --sport 20 -j ACCEPT

# IGMP Multicast
$IP4T -A INPUT -p igmp -s $NET4 -d $MULTICAST4_4 -j ACCEPT
$IP4T -A INPUT -p igmp -s $NULL4 -d $MULTICAST4_4 -j ACCEPT
$IP6T -A INPUT -p igmp -s $NET6 -d $MULTICAST6_8 -j ACCEPT

# mDNS
$IP4T -A INPUT -p udp -s $NET4 -d $MULTICAST4_4 --dport 5353 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $MULTICAST6_8 --dport 5353 -j ACCEPT

# DLNA (TODO related?)
$IP4T -A INPUT -p udp -s $GATEWAY4 -d $NET4 --sport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $GATEWAY6 -d $NET6 --sport 1900 -j ACCEPT

# Plex
$IP4T -A INPUT -p tcp -d $NET4 -m multiport --dport 32400,32401 -j ACCEPT
$IP6T -A INPUT -p tcp -d $NET6 -m multiport --dport 32400,32401 -j ACCEPT
$IP4T -A INPUT -p tcp -d $NET4 --sport 443 -j ACCEPT # psh?
$IP6T -A INPUT -p tcp -d $NET6 --sport 443 -j ACCEPT # psh?

# Plex network discovery
$IP4T -A INPUT -p udp -s $NET4 -d $BCAST4 -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_IL_AN6 -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_LL_AN6 -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA
$IP4T -A INPUT -p udp -s $NET4 -d $SSDP4 --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_LL --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_SL --dport 1900 -j ACCEPT

# TV
$IP4T -A INPUT -p udp -s $NET4 -d $SSDP4 --dport 15600 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_LL --dport 15600 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $SSDP6_SL --dport 15600 -j ACCEPT

# KDE Connect
$IP4T -A INPUT -p tcp -s $NET4 -d $NET4 -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $NET6 -m multiport --dport 1714:1764 -j ACCEPT
$IP4T -A INPUT -p udp -s $NET4 -d $NET4 -m multiport --dport 1714:1764 -j ACCEPT
$IP4T -A INPUT -p udp -s $NET4 -d $BCAST4_ALL -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $NET6 -m multiport --dport 1714:1764 -j ACCEPT

# KDE Connect (Scanning)
$IP4T -A INPUT -p tcp -s $NET4 -d $BCAST4 -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $ALL_IL_AN6 -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -d $ALL_LL_AN6 -m multiport --dport 1714:1764 -j ACCEPT
$IP4T -A INPUT -p udp -s $NET4 -d $BCAST4 -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_IL_AN6 -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -d $ALL_LL_AN6 -m multiport --dport 1714:1764 -j ACCEPT

# Discord
$IP4T -A INPUT -p udp -d $NET4 -m multiport --dport 50000:65535 -j ACCEPT
$IP6T -A INPUT -p udp -d $NET6 -m multiport --dport 50000:65535 -j ACCEPT

# all local for now
$IP4T -A INPUT -s $NET4 -d $NET4 -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $NET6 -j ACCEPT
$IP6T -A INPUT -s $LL6 -j ACCEPT
$IP6T -A INPUT -d $LL6 -j ACCEPT

# SMB
$IP4T -A INPUT -p tcp -s $NET4 -m multiport --dport 137,139,445,5357 -j ACCEPT
$IP6T -A INPUT -p tcp -s $NET6 -m multiport --dport 137,139,445,5357 -j ACCEPT
$IP4T -A INPUT -p udp -s $NET4 -m multiport --dport 3702 -j ACCEPT
$IP6T -A INPUT -p udp -s $NET6 -m multiport --dport 3702 -j ACCEPT

# and all local broadcast
$IP4T -A INPUT -s $NET4 -d $BCAST4 -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $ALL_IL_AN6 -j ACCEPT
$IP6T -A INPUT -s $NET6 -d $ALL_LL_AN6 -j ACCEPT

# all local on ham
$IP4T -A INPUT -s $AMPR_NET4 -d $AMPR_IP4 -j ACCEPT

$IP4T -A INPUT -i waydroid0 -j ACCEPT

# except ssh/https/ircs
$IP4T -A INPUT -s $AMPR_NET4 -d $AMPR_IP4 -p tcp -m multiport --dport 22,443,6697 -j DROP

# normally disable icmp but today allow it (todo rate limit)
$IP4T -A INPUT -p icmp -j ACCEPT

# ICMPv6 is more necessary than ICMPv4
$IP6T -A INPUT -p icmpv6 -j ACCEPT

# Invalid
$IP4T -A INPUT -m conntrack --ctstate INVALID -j DROP
$IP6T -A INPUT -m conntrack --ctstate INVALID -j DROP

# Existing
$IP4T -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP4T -A INPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A INPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
# $IP4T -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4
# $IP6T -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4

$IP4T -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"
$IP6T -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"

# Rest
$IP4T -A INPUT -j DROP
$IP6T -A INPUT -j DROP


## FORWARD
$IP4T -P FORWARD ACCEPT
$IP6T -P FORWARD ACCEPT

## OUTPUT
$IP4T -P OUTPUT ACCEPT
$IP6T -P OUTPUT ACCEPT

# Block harmful hosts
# $IP4T -A OUTPUT -p tcp --dport 443 -d 192.0.64.0/18 -j DROP # tum
$IP4T -A OUTPUT -p tcp --dport 443 -d 162.159.140.229 -j DROP # twtx's cloudflare
$IP4T -A OUTPUT -p tcp --dport 443 -d 172.66.0.227 -j DROP # twtx's cloudflare

# Mwahahaha
../private/net/secret-firewall-entries.sh

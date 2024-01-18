#!/bin/sh
set -euo pipefail
trap pwd ERR

export HOME_ROUTER=192.168.1.1
export HOME_ROUTER6=::1/128
export HOME_BCAST=192.168.1.255
export HOME_ALL_IL_AN=ff01::1
export HOME_ALL_LL_AN=ff02::1
export HOME_ALL_DHCP=ff02::1:2
export HOME_NET=192.168.1.0/24
export HOME_LL6=fe80::/10
export HOME_IP=2603:c020:c005:7c00:4b99:973c:65d2:5837
export MDNS6=ff02::fb # dealt with already by MULTICAST6_8
export HOME_NET6=fe80::/10
export AMPR_HOME=44.63.0.51/32
export AMPR_NET=44.0.0.0/8

export PRIVNET_8=10.0.0.0/8
export PRIVNET_12=172.16.0.0/12
# export PRIVNET_16=192.168.0.0/16
export LOCAL_8=127.0.0.0/8
export LOCAL_128=::1/128
export MULTICAST_4=224.0.0.0/4
export MULTICAST6_8=ff00::/8
export SSDP=239.255.255.250
export SSDP6_LL=239.255.255.250
export SSDP6_SL=239.255.255.250
export THISNET=0.0.0.0
export BCAST=255.255.255.255
export DHCP_SERVER_PORT=67
export DHCP_CLIENT_PORT=68
export DHCP6_SERVER_PORT=547
export DHCP6_CLIENT_PORT=546

export IPT=iptables-nft
export IP6T=ip6tables-nft

$IPT -F
$IP6T -F

## INPUT
$IPT -P INPUT DROP
$IP6T -P INPUT DROP

# SSH in
$IPT -A INPUT -p tcp --dport 22 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 22 -j ACCEPT

# Web in
$IPT -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IP6T -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IPT -A INPUT -p tcp --dport 443 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 443 -j ACCEPT

# Sauer in
$IPT -A INPUT -p udp --dport 28785 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28785 -j ACCEPT
$IPT -A INPUT -p udp --dport 28786 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28786 -j ACCEPT

# Dev MySQL
# $IPT -A INPUT -p tcp -s $PRIVNET_12 --dport 3306 -j ACCEPT

# Internal networks
$IPT -A INPUT -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

$IPT -A INPUT -p tcp -s $PRIVNET_8 -d $PRIVNET_8 -j ACCEPT

# DHCP
$IPT -A INPUT -p udp -s $THISNET -d $BCAST --sport $DHCP_CLIENT_PORT --dport $DHCP_SERVER_PORT -j ACCEPT
$IPT -A INPUT -p udp -s $HOME_ROUTER -d $BCAST --sport $DHCP_SERVER_PORT --dport $DHCP_CLIENT_PORT -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_LL6 -d $HOME_LL6 --sport $DHCP6_SERVER_PORT --dport $DHCP6_CLIENT_PORT -j ACCEPT

# BitTorrent
$IPT -A INPUT -p tcp -d $HOME_NET --dport 6881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $HOME_NET6 --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp -d $HOME_NET --dport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $HOME_NET6 --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp -d $HOME_NET --sport 6881 -j ACCEPT
$IP6T -A INPUT -p udp -d $HOME_NET6 --sport 6881 -j ACCEPT
# $IPT -A INPUT -p udp -d $HOME_NET --dport 6881 -j ACCEPT
# $IP6T -A INPUT -p udp -d $HOME_NET6 --dport 6881 -j ACCEPT

# DHT
$IPT -A INPUT -p tcp -d $HOME_NET --dport 7881 -j ACCEPT
$IP6T -A INPUT -p tcp -d $HOME_NET6 --dport 7881 -j ACCEPT
$IPT -A INPUT -p udp -d $HOME_NET --dport 7881 -j ACCEPT
$IP6T -A INPUT -p udp -d $HOME_NET6 --dport 7881 -j ACCEPT

# Tracker
# $IPT -A INPUT -p tcp -d $HOME_NET --dport 8881 -j ACCEPT
# $IP6T -A INPUT -p tcp -d $HOME_NET6 --dport 8881 -j ACCEPT
# $IPT -A INPUT -p udp -d $HOME_NET --dport 8881 -j ACCEPT
# $IP6T -A INPUT -p udp -d $HOME_NET6 --dport 8881 -j ACCEPT

# FTP responses
$IPT -A INPUT -p tcp -d $HOME_NET --sport 20 -j ACCEPT
$IP6T -A INPUT -p tcp -d $HOME_NET6 --sport 20 -j ACCEPT

# IGMP Multicast
$IPT -A INPUT -p igmp -s $HOME_NET -d $MULTICAST_4 -j ACCEPT
$IP6T -A INPUT -p igmp -s $HOME_NET6 -d $MULTICAST6_8 -j ACCEPT

# mDNS
$IPT -A INPUT -p udp -s $HOME_NET -d $MULTICAST_4 --sport 5353 --dport 5353 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $MULTICAST6_8 --sport 5353 --dport 5353 -j ACCEPT

# DLNA (TODO related?)
$IPT -A INPUT -p udp -s $HOME_ROUTER -d $HOME_NET --sport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_ROUTER6 -d $HOME_NET6 --sport 1900 -j ACCEPT

# Plex
$IPT -A INPUT -p tcp -d $HOME_NET -m multiport --dport 32400,32401 -j ACCEPT
$IP6T -A INPUT -p tcp -d $HOME_NET6 -m multiport --dport 32400,32401 -j ACCEPT
$IPT -A INPUT -p tcp -d $HOME_NET --sport 443 -j ACCEPT # psh?
$IP6T -A INPUT -p tcp -d $HOME_NET6 --sport 443 -j ACCEPT # psh?

# Plex network discovery
$IPT -A INPUT -p udp -s $HOME_NET -d $HOME_BCAST -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $HOME_ALL_IL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $HOME_ALL_LL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA
$IPT -A INPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET -d $SSDP6_LL --dport 1900 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET -d $SSDP6_SL --dport 1900 -j ACCEPT

# KDE Connect
$IPT -A INPUT -p tcp -s $HOME_NET -d $HOME_NET -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $HOME_NET6 -d $HOME_NET6 -m multiport --dport 1714:1764 -j ACCEPT
$IPT -A INPUT -p udp -s $HOME_NET -d $HOME_NET -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $HOME_NET6 -m multiport --dport 1714:1764 -j ACCEPT

# KDE Connect (Scanning)
$IPT -A INPUT -p tcp -s $HOME_NET -d $BCAST -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $HOME_NET6 -d $HOME_ALL_IL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p tcp -s $HOME_NET6 -d $HOME_ALL_LL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IPT -A INPUT -p udp -s $HOME_NET -d $BCAST -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $HOME_ALL_IL_AN -m multiport --dport 1714:1764 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -d $HOME_ALL_LL_AN -m multiport --dport 1714:1764 -j ACCEPT

# Discord
$IPT -A INPUT -p udp -d $HOME_NET -m multiport --dport 50000:65535 -j ACCEPT
$IP6T -A INPUT -p udp -d $HOME_NET6 -m multiport --dport 50000:65535 -j ACCEPT

# Mail server
# $IPT -A INPUT -p tcp -d $HOME_NET --dport 25 -j ACCEPT
# $IP6T -A INPUT -p tcp -d $HOME_NET6 --dport 25 -j ACCEPT

# all local for now
$IPT -A INPUT -s $HOME_NET -d $HOME_NET -j ACCEPT
$IP6T -A INPUT -s $HOME_NET6 -d $HOME_NET6 -j ACCEPT

# SMB
$IPT -A INPUT -p tcp -s $HOME_NET -m multiport --dport 137,139,445,5357 -j ACCEPT
$IP6T -A INPUT -p tcp -s $HOME_NET6 -m multiport --dport 137,139,445,5357 -j ACCEPT
$IPT -A INPUT -p udp -s $HOME_NET -m multiport --dport 3702 -j ACCEPT
$IP6T -A INPUT -p udp -s $HOME_NET6 -m multiport --dport 3702 -j ACCEPT

# and all local broadcast
$IPT -A INPUT -s $HOME_NET -d $HOME_BCAST -j ACCEPT
$IP6T -A INPUT -s $HOME_NET6 -d $HOME_ALL_IL_AN -j ACCEPT
$IP6T -A INPUT -s $HOME_NET6 -d $HOME_ALL_LL_AN -j ACCEPT

# all local on ham
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -j ACCEPT

# except ssh/https/ircs
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -p tcp -m multiport --dport 22,443,6697 -j DROP

# lo
$IPT -A INPUT -s $LOCAL_8 -d $LOCAL_8 -i lo -j ACCEPT
$IP6T -A INPUT -s $LOCAL_128 -d $LOCAL_128 -i lo -j ACCEPT

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

# Logl
$IPT -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4
$IP6T -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4

$IPT -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"
$IP6T -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"

# Rest
$IPT -A INPUT -j DROP
$IP6T -A INPUT -j DROP


## FORWARD
$IPT -P FORWARD DROP
$IP6T -P FORWARD DROP

# Docker
# $IPT -A FORWARD -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

$IPT -A FORWARD -p tcp --sport 443 -d $PRIVNET_12 -j ACCEPT
$IPT -A FORWARD -p tcp --dport 443 -s $PRIVNET_12 -j ACCEPT

$IPT -A FORWARD -p tcp --sport 22 -d $PRIVNET_12 -j ACCEPT
$IPT -A FORWARD -p tcp --dport 22 -s $PRIVNET_12 -j ACCEPT

$IPT -A FORWARD -p udp --sport 53 -d $PRIVNET_12 -j ACCEPT # TODO related
$IPT -A FORWARD -p udp --dport 53 -s $PRIVNET_12 -j ACCEPT

$IPT -A FORWARD -p udp --sport $DHCP_SERVER_PORT -d $PRIVNET_12 -j ACCEPT # TODO related
$IPT -A FORWARD -p udp --dport $DHCP_SERVER_PORT -s $PRIVNET_12 -j ACCEPT

$IPT -A FORWARD -p tcp -d $PRIVNET_12 --dport 80 -j ACCEPT # TODO related

$IPT -A FORWARD -p tcp -d $PRIVNET_12 --dport 8080 -j ACCEPT # TODO related

# Log
$IPT -A FORWARD -j LOG --log-prefix "FORWARD: DROP: " --log-level 4
$IP6T -A FORWARD -j LOG --log-prefix "FORWARD: DROP: " --log-level 4

$IPT -A FORWARD -j NFLOG --nflog-group 2 --nflog-prefix "FORWARD:"
$IP6T -A FORWARD -j NFLOG --nflog-group 2 --nflog-prefix "FORWARD:"

# Existing
$IPT -A FORWARD -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A FORWARD -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A FORWARD -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Rest
$IPT -A FORWARD -j DROP
$IP6T -A FORWARD -j DROP


## OUTPUT
$IPT -P OUTPUT DROP
$IP6T -P OUTPUT DROP

# Debug
$IPT -A OUTPUT -p tcp --dport 80 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 80 -j ACCEPT

# Web out
$IPT -A OUTPUT -p tcp --dport 443 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 443 -j ACCEPT

# SSH out
$IPT -A OUTPUT -p tcp --dport 22 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 22 -j ACCEPT

# Gmail SMTP TLS out
$IPT -A OUTPUT -p tcp --dport 587 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 587 -j ACCEPT

# IMAP TLS out
$IPT -A OUTPUT -p tcp --dport 993 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 993 -j ACCEPT

# DNS out
$IPT -A OUTPUT -p udp --dport 53 -j ACCEPT
$IP6T -A OUTPUT -p udp --dport 53 -j ACCEPT

# DHCP
$IPT -A OUTPUT -p udp --dport $DHCP_SERVER_PORT -j ACCEPT
$IP6T -A OUTPUT -p udp --sport $DHCP6_CLIENT_PORT --dport $DHCP6_SERVER_PORT -s $HOME_LL6 -d $HOME_ALL_DHCP -j ACCEPT

# SSDP
$IPT -A OUTPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT
$IPT -A OUTPUT -p udp -s $HOME_NET -d $BCAST --dport 1900 -j ACCEPT

# NAT port mapping
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_ROUTER --dport 5351 -j ACCEPT

# NTP
$IPT -A OUTPUT -p udp --dport 123 -j ACCEPT
$IP6T -A OUTPUT -p udp --dport 123 -j ACCEPT

# Google Meet
$IPT -A OUTPUT -p udp --dport 19302:19309 -j ACCEPT
$IP6T -A OUTPUT -p udp --dport 19302:19309 -j ACCEPT

# Docker
# $IPT -A OUTPUT -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

# Roqqett
$IPT -A OUTPUT -p tcp --dport 5000:6000 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 5000:6000 -j ACCEPT
$IPT -A OUTPUT -p tcp -d $PRIVNET_12 --dport 80 -j ACCEPT # TODO related
$IPT -A OUTPUT -p tcp -d $PRIVNET_12 --dport 8080 -j ACCEPT # TODO related

# MDNS Out
$IPT -A OUTPUT -p udp -s $HOME_NET -d $MULTICAST_4 --sport 5353 --dport 5353 -j ACCEPT
$IPT6 -A OUTPUT -p udp -s $HOME_NET6 -d $MULTICAST6_8 --sport 5353 --dport 5353 -j ACCEPT
$IPT6 -A 

# NetBIOS
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_BCAST --sport 137 --dport 137 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $HOME_ALL_IL_AN --sport 137 --dport 137 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $HOME_ALL_LL_AN --sport 137 --dport 137 -j ACCEPT

# Plex network discovery - still gets blocked somehow
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_BCAST -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $HOME_ALL_IL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $HOME_ALL_LL_AN -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA (SSDP/UPnP)
$IPT -A OUTPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $SSDP6_LL --dport 1900 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -d $SSDP6_SL --dport 1900 -j ACCEPT

# BitTorrent
$IPT -A OUTPUT -p tcp -s $HOME_NET --sport 6881 -j ACCEPT # related?
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 --sport 6881 -j ACCEPT # related?
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 6881 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 --dport 6881 -j ACCEPT
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 6881 -j ACCEPT # related?
$IP6T -A OUTPUT -p udp -s $HOME_NET6 --sport 6881 -j ACCEPT # related?

# DHT
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 7881 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 --sport 7881 -j ACCEPT

# Tracker
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 8881 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 --sport 8881 -j ACCEPT

# irc
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 6697 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 --dport 6697 -j ACCEPT

# whois
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 43 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 --dport 43 -j ACCEPT

# FTP
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 21 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 --dport 21 -j ACCEPT

# SMB
$IPT -A OUTPUT -p tcp -s $HOME_NET -m multiport --dport 137,139,445,5357 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $HOME_NET6 -m multiport --dport 137,139,445,5357 -j ACCEPT
$IPT -A OUTPUT -p udp -s $HOME_NET -m multiport --dport 3702 -j ACCEPT
$IP6T -A OUTPUT -p udp -s $HOME_NET6 -m multiport --dport 3702 -j ACCEPT

# websdr
$IPT -A OUTPUT -p tcp -s $HOME_NET -d 192.87.173.88 --dport 8901 -j ACCEPT

# all local on ham
$IPT -A OUTPUT -s $AMPR_HOME -d $AMPR_NET -j ACCEPT

# except ssh/https/ircs
$IPT -A OUTPUT -s $AMPR_HOME -d $AMPR_NET -p tcp -m multiport --dport 22,443,6697 -j DROP

# lo
$IPT -A OUTPUT -s $LOCAL_8 -d $LOCAL_8 -o lo -j ACCEPT
$IP6T -A OUTPUT -s $LOCAL_128 -d $LOCAL_128 -i lo -j ACCEPT

# all from VPN
$IPT -A OUTPUT -p tcp -s $PRIVNET_8 -d $PRIVNET_12 -j ACCEPT

# objects-us-east-1.dream.io for nix
# $IPT -A OUTPUT -p tcp --dport 80 -d 208.113.201.37 -j ACCEPT
# ip6tables-nft -A OUTPUT -p tcp --dport 80 -d 2607:f298:5:ee00::33 -j ACCEPT


# all local for now
$IPT -A OUTPUT -s $HOME_NET -d $HOME_NET -j ACCEPT

# ICMPv6 is more necessary than ICMPv4
$IP6T -A OUTPUT -p icmpv6 -j ACCEPT

# Existing
$IPT -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A OUTPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
$IPT -A OUTPUT -j LOG --log-prefix "OUTPUT: DROP: " --log-level 4
$IP6T -A OUTPUT -j LOG --log-prefix "OUTPUT: DROP: " --log-level 4

$IPT -A OUTPUT -j NFLOG --nflog-group 2 --nflog-prefix "OUTPUT:"
$IP6T -A OUTPUT -j NFLOG --nflog-group 2 --nflog-prefix "OUTPUT:"

# Rest
$IPT -A OUTPUT -j DROP
$IP6T -A OUTPUT -j DROP

#!/bin/sh
set -euo pipefail
trap pwd ERR

export SRV_ROUTER=10.0.0.1
export SRV_BCAST=10.0.0.255
export SRV_NET=10.0.0.0/24
export SRV_LL6=fe80::/10
export SRV_IP=2603:c020:c005:7c00:4b99:973c:65d2:5837
export MDNS6=ff02::fb
export LOCAL_8=127.0.0.0/8
export LOCAL_128=::1/128
export SRV_ALL_IL_AN=ff01::1
export SRV_ALL_LL_AN=ff02::1
export SRV_ALL_DHCP=ff02::1:2
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

# SMTP in
$IPT -A INPUT -p tcp --dport 25 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 25 -j ACCEPT

# SMTPS in
$IPT -A INPUT -p tcp --dport 587 -j ACCEPT
$IP6T -A INPUT -p tcp --dport 587 -j ACCEPT

# Sauer in
$IPT -A INPUT -p udp --dport 28785 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28785 -j ACCEPT
$IPT -A INPUT -p udp --dport 28786 -j ACCEPT
$IP6T -A INPUT -p udp --dport 28786 -j ACCEPT

# DHCP
$IPT -A INPUT -p udp -s $THISNET -d $BCAST --sport $DHCP_CLIENT_PORT --dport $DHCP_SERVER_PORT -j ACCEPT
$IPT -A INPUT -p udp -s $SRV_ROUTER -d $BCAST --sport $DHCP_SERVER_PORT --dport $DHCP_CLIENT_PORT -j ACCEPT
$IP6T -A INPUT -p udp -s $SRV_LL6 -d $SRV_LL6 --sport $DHCP6_SERVER_PORT --dport $DHCP6_CLIENT_PORT -j ACCEPT

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
# $IPT -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4
# $IP6T -A INPUT -j LOG --log-prefix "INPUT: DROP: " --log-level 4

$IPT -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"
$IP6T -A INPUT -j NFLOG --nflog-group 2 --nflog-prefix "INPUT:"

# Rest
$IPT -A INPUT -j DROP
$IP6T -A INPUT -j DROP

## FORWARD
$IPT -P FORWARD DROP
$IP6T -P FORWARD DROP

# Log
# $IPT -A FORWARD -j LOG --log-prefix "FORWARD: DROP: " --log-level 4
# $IP6T -A FORWARD -j LOG --log-prefix "FORWARD: DROP: " --log-level 4

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

# SMTP out
$IPT -A OUTPUT -p tcp --dport 25 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 25 -j ACCEPT

# SMTPS out
$IPT -A OUTPUT -p tcp --dport 587 -j ACCEPT
$IP6T -A OUTPUT -p tcp --dport 587 -j ACCEPT

# DNS out
$IPT -A OUTPUT -p udp --dport 53 -j ACCEPT
$IP6T -A OUTPUT -p udp --dport 53 -j ACCEPT

# DHCP
$IPT -A OUTPUT -p udp --dport $DHCP_SERVER_PORT -j ACCEPT
$IP6T -A OUTPUT -p udp --sport $DHCP6_CLIENT_PORT --dport $DHCP6_SERVER_PORT -s $SRV_LL6 -d $SRV_ALL_DHCP -j ACCEPT

# NTP
$IPT -A OUTPUT -p udp --dport 123 -j ACCEPT
$IP6T -A OUTPUT -p udp --dport 123 -j ACCEPT

# irc
$IPT -A OUTPUT -p tcp -s $SRV_NET --dport 6697 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $SRV_IP --dport 6697 -j ACCEPT

# whois
$IPT -A OUTPUT -p tcp -s $SRV_NET --dport 43 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $SRV_IP --dport 43 -j ACCEPT

# FTP
$IPT -A OUTPUT -p tcp -s $SRV_NET --dport 21 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $SRV_IP --dport 21 -j ACCEPT

# SMB
$IPT -A OUTPUT -p tcp -s $SRV_NET -m multiport --dport 137,139,445,3702,5357 -j ACCEPT
$IP6T -A OUTPUT -p tcp -s $SRV_IP -m multiport --dport 137,139,445,3702,5357 -j ACCEPT

# lo
$IPT -A OUTPUT -s $LOCAL_8 -d $LOCAL_8 -o lo -j ACCEPT
$IP6T -A OUTPUT -s $LOCAL_128 -d $LOCAL_128 -o lo -j ACCEPT

# all local for now
# $IPT -A OUTPUT -s $SRV_NET -d $SRV_NET -j ACCEPT
# $IP6T -A OUTPUT -s $SRV_IP -d $SRV_LL6 -j ACCEPT

# ICMPv6 is more necessary than ICMPv4
$IP6T -A OUTPUT -p icmpv6 -j ACCEPT

# Existing
$IPT -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IP6T -A OUTPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
# $IPT -A OUTPUT -j LOG --log-prefix "OUTPUT: DROP: " --log-level 4
# $IP6T -A OUTPUT -j LOG --log-prefix "OUTPUT: DROP: " --log-level 4

$IPT -A OUTPUT -j NFLOG --nflog-group 2 --nflog-prefix "OUTPUT:"
$IP6T -A OUTPUT -j NFLOG --nflog-group 2 --nflog-prefix "OUTPUT:"

# Rest
$IPT -A OUTPUT -j DROP
$IP6T -A OUTPUT -j DROP

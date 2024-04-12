#!/bin/sh
set -euo pipefail
trap pwd ERR

iptables -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -p tcp --dport 22 -j REJECT

ip6tables -F
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT
ip6tables -A INPUT -p tcp --dport 22 -j REJECT
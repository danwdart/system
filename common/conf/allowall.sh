#!/bin/sh
set -euo pipefail
trap pwd ERR

iptables -F
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -A INPUT -p tcp --dport 22 -j REJECT
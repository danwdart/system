#!/bin/sh
set -euo pipefail
trap pwd ERR

source ./common.sh
source ../private/net/.env

$IP4T -F
$IP4T -P INPUT ACCEPT
$IP4T -P OUTPUT ACCEPT
$IP4T -P FORWARD ACCEPT
$IP4T -A INPUT -p tcp --dport 22 -j REJECT

$IP6T -F
$IP6T -P INPUT ACCEPT
$IP6T -P OUTPUT ACCEPT
$IP6T -P FORWARD ACCEPT
$IP6T -A INPUT -p tcp --dport 22 -j REJECT

# Mwahahaha
../private/net/secret-firewall-entries.sh
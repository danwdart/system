export HOME_ROUTER=192.168.1.1
export HOME_BCAST=192.168.1.255
export HOME_NET=192.168.1.0/24

export AMPR_HOME=44.131.255.4/32
export AMPR_NET=44.0.0.0/8

export PRIVNET_8=10.0.0.0/8
export PRIVNET_12=172.16.0.0/12
# export PRIVNET_16=192.168.0.0/16
export LOCAL_8=127.0.0.0/8
export MULTICAST_4=224.0.0.0/4
export SSDP=239.255.255.250
export THISNET=0.0.0.0
export BCAST=255.255.255.255
export DHCP_SERVER_PORT=67
export DHCP_CLIENT_PORT=68

export IPT=iptables-nft

$IPT -F

## INPUT
$IPT -P INPUT DROP

# Web in
$IPT -A INPUT -p tcp --dport 80 -j ACCEPT # Might as well for acme
$IPT -A INPUT -p tcp --dport 443 -j ACCEPT

# Dev MySQL
# $IPT -A INPUT -p tcp -s $PRIVNET_12 --dport 3306 -j ACCEPT

# Internal networks
$IPT -A INPUT -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

# DHCP
$IPT -A INPUT -p udp -s $THISNET -d $BCAST --sport $DHCP_CLIENT_PORT --dport $DHCP_SERVER_PORT -j ACCEPT
$IPT -A INPUT -p udp -s $HOME_ROUTER -d $BCAST --sport $DHCP_SERVER_PORT --dport $DHCP_CLIENT_PORT -j ACCEPT

# BitTorrent
$IPT -A INPUT -p tcp --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp --dport 6881 -j ACCEPT
$IPT -A INPUT -p udp --sport 6881 -j ACCEPT
# $IPT -A INPUT -p udp -d $HOME_NET --dport 6881 -j ACCEPT

# DHT
$IPT -A INPUT -p tcp --dport 7881 -j ACCEPT
$IPT -A INPUT -p udp --dport 7881 -j ACCEPT

# Tracker
# $IPT -A INPUT -p tcp -d $HOME_NET --dport 8881 -j ACCEPT
# $IPT -A INPUT -p udp -d $HOME_NET --dport 8881 -j ACCEPT

# FTP responses
$IPT -A INPUT -p tcp -d $HOME_NET --sport 20 -j ACCEPT

# IGMP Multicast
$IPT -A INPUT -p igmp -s $HOME_ROUTER -d $MULTICAST_4 -j ACCEPT

# mDNS
$IPT -A INPUT -p udp -s $HOME_NET -d $MULTICAST_4 --sport 5353 --dport 5353 -j ACCEPT

# DLNA (TODO related?)
$IPT -A INPUT -p udp -s $HOME_ROUTER -d $HOME_NET --sport 1900 -j ACCEPT

# Plex
$IPT -A INPUT -p tcp -d $HOME_NET -m multiport --dport 32400,32401 -j ACCEPT
$IPT -A INPUT -p tcp -d $HOME_NET --sport 443 -j ACCEPT # psh?

# Plex network discovery
$IPT -A INPUT -p udp -s $HOME_NET -d $HOME_BCAST -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA
$IPT -A INPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT

# Mail server
# $IPT -A INPUT -p tcp -d $HOME_NET --dport 25 -j ACCEPT

# all local for now
$IPT -A INPUT -s $HOME_NET -d $HOME_NET -j ACCEPT

# and all local broadcast
$IPT -A INPUT -s $HOME_NET -d $HOME_BCAST -j ACCEPT

# all local on ham
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -j ACCEPT

# except ssh/https/ircs
$IPT -A INPUT -s $AMPR_NET -d $AMPR_HOME -p tcp -m multiport --dport 22,443,6697 -j REJECT

# lo
$IPT -A INPUT -s $LOCAL_8 -d $LOCAL_8 -i lo -j ACCEPT

# Invalid
$IPT -A INPUT -m conntrack --ctstate INVALID -j DROP

# Existing
$IPT -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
$IPT -A INPUT -j LOG --log-prefix "INPUT: REJECT: " --log-level 4

# Rest
$IPT -A INPUT -j REJECT


## FORWARD
$IPT -P FORWARD DROP

# Docker
$IPT -A FORWARD -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

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
$IPT -A FORWARD -j LOG --log-prefix "FORWARD: REJECT: " --log-level 4

# Existing
$IPT -A FORWARD -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A FORWARD -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Rest
$IPT -A FORWARD -j REJECT


## OUTPUT
$IPT -P OUTPUT DROP

# Debug
$IPT -A OUTPUT -p tcp --dport 80 -j ACCEPT

# Web out
$IPT -A OUTPUT -p tcp --dport 443 -j ACCEPT

# SSH out
$IPT -A OUTPUT -p tcp --dport 22 -j ACCEPT

# Gmail SMTP TLS out
$IPT -A OUTPUT -p tcp --dport 587 -j ACCEPT

# IMAP TLS out
$IPT -A OUTPUT -p tcp --dport 993 -j ACCEPT

# DNS out
$IPT -A OUTPUT -p udp --dport 53 -j ACCEPT

# DHCP
$IPT -A OUTPUT -p udp --dport $DHCP_SERVER_PORT -j ACCEPT

# SSDP
$IPT -A OUTPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT
$IPT -A OUTPUT -p udp -s $HOME_NET -d $BCAST --dport 1900 -j ACCEPT

# NAT port mapping
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_ROUTER --dport 5351 -j ACCEPT

# NTP
$IPT -A OUTPUT -p udp --dport 123 -j ACCEPT

# Google Meet
$IPT -A OUTPUT -p udp --dport 19302:19309 -j ACCEPT

# Docker
$IPT -A OUTPUT -p tcp -s $PRIVNET_12 -d $PRIVNET_12 -j ACCEPT

# Roqqett
$IPT -A OUTPUT -p tcp --dport 5000:6000 -j ACCEPT
$IPT -A OUTPUT -p tcp -d $PRIVNET_12 --dport 80 -j ACCEPT # TODO related
$IPT -A OUTPUT -p tcp -d $PRIVNET_12 --dport 8080 -j ACCEPT # TODO related

# MDNS Out
$IPT -A OUTPUT -p udp -s $HOME_NET -d $MULTICAST_4 --sport 5353 --dport 5353 -j ACCEPT

# NetBIOS
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_BCAST --sport 137 --dport 137 -j ACCEPT

# Plex network discovery - still gets blocked somehow
$IPT -A OUTPUT -p udp -s $HOME_NET -d $HOME_BCAST -m multiport --dport 32410,32412,34213,32414 -j ACCEPT

# DLNA (SSDP/UPnP)
$IPT -A OUTPUT -p udp -s $HOME_NET -d $SSDP --dport 1900 -j ACCEPT

# BitTorrent
$IPT -A OUTPUT -p tcp -s $HOME_NET --sport 6881 -j ACCEPT # related?
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 6881 -j ACCEPT
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 6881 -j ACCEPT # related?

# DHT
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 7881 -j ACCEPT

# Tracker
$IPT -A OUTPUT -p udp -s $HOME_NET --sport 8881 -j ACCEPT

# irc
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 6697 -j ACCEPT

# whois
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 43 -j ACCEPT

# FTP
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 21 -j ACCEPT

# SMB
$IPT -A OUTPUT -p tcp -s $HOME_NET --dport 445 -j ACCEPT

# websdr
$IPT -A OUTPUT -p tcp -s $HOME_NET -d 192.87.173.88 --dport 8901 -j ACCEPT

# all local on ham
$IPT -A OUTPUT -s $AMPR_HOME -d $AMPR_NET -j ACCEPT

# except ssh/https/ircs
$IPT -A OUTPUT -s $AMPR_HOME -d $AMPR_NET -p tcp -m multiport --dport 22,443,6697 -j REJECT

# lo
$IPT -A OUTPUT -s $LOCAL_8 -d $LOCAL_8 -o lo -j ACCEPT

# all from VPN
$IPT -A OUTPUT -p tcp -s $PRIVNET_8 -d $PRIVNET_12 -j ACCEPT

# objects-us-east-1.dream.io for nix
# $IPT -A OUTPUT -p tcp --dport 80 -d 208.113.201.37 -j ACCEPT
# ip6tables-nft -A OUTPUT -p tcp --dport 80 -d 2607:f298:5:ee00::33 -j ACCEPT


# all local for now
$IPT -A OUTPUT -s $HOME_NET -d $HOME_NET -j ACCEPT

# Existing
$IPT -A OUTPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
$IPT -A OUTPUT -p udp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log
$IPT -A OUTPUT -j LOG --log-prefix "OUTPUT: REJECT: " --log-level 4

# Rest
$IPT -A OUTPUT -j REJECT

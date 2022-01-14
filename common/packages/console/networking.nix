{ pkgs, ... }:
with pkgs; [
    autossh
    bind # host, nslookup etc
    bud
    docker-proxy
    doctl # run doctl auth init before use
    hans
    iodine
    irssi
    mailutils
    openvpn
    python39Packages.mitmproxy
    ngrok
    # proxytunnel # insecure openssl
    slirp4netns
    tunnelto # like ngrok?
]
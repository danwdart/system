pkgs:
with pkgs; [
    autossh
    azure-cli # TODO split?
    bind # host, nslookup etc
    docker-proxy
    doctl # run doctl auth init before use
    hans
    iodine
    irssi
    mailutils
    nixops
    openvpn
    python39Packages.mitmproxy
    ngrok
    # proxytunnel # insecure openssl
    slirp4netns
]
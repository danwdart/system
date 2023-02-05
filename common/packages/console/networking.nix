pkgs:
with pkgs; [
    autossh
    # azure-cli # TODO split? # broken
    bind # host, nslookup etc
    docker-proxy
    doctl # run doctl auth init before use
    hans
    iodine
    irssi
    mailutils
    # nixops # build failure
    openvpn
    protonvpn-cli
    python310Packages.mitmproxy
    python310Packages.protonvpn-nm-lib
    ngrok
    # proxytunnel # insecure openssl
    slirp4netns
]
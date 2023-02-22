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
    # python312Packages.mitmproxy # fails to build
    # python312Packages.protonvpn-nm-lib # fails to build
    ngrok
    # proxytunnel # insecure openssl
    slirp4netns
]
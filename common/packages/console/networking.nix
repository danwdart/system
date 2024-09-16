pkgs:
with pkgs; [
    autossh
    # azure-cli # TODO split? # broken
    bind # host, nslookup etc
    # docker-proxy
    doctl # run doctl auth init before use
    hans
    iodine
    irssi
    mailutils
    # nixops # build failure
    openvpn
    # postgrest
    # protonvpn-cli
    # python313Packages.mitmproxy # fails to build
    # python313Packages.protonvpn-nm-lib # fails to build
    # ngrok
    # proxytunnel # insecure openssl
    slirp4netns
]
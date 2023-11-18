pkgs:
with pkgs; [
    autossh
    # azure-cli # TODO split? # broken
    bind # host, nslookup etc
    # docker-proxy
    doctl # run doctl auth init before use
    hans
    # (haskell.packages.ghc94.override { overrides = self: super: rec { fuzzyset = haskell.lib.doJailbreak (haskell.lib.markUnbroken super.fuzzyset); configurator-pg = haskell.lib.doJailbreak (haskell.lib.markUnbroken super.configurator-pg); hasql-pool = haskell.lib.dontCheck (self.callHackage "hasql-pool" "0.10" {}); postgrest = haskell.lib.dontCheck ( haskell.lib.doJailbreak (self.callCabal2nix "postgrest" (builtins.fetchTarball "https://github.com/PostgREST/postgrest/archive/refs/tags/v11.2.1.tar.gz") {})); }; }).postgrest
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
pkgs:
let
    awsvpnclientRepo = builtins.fetchTarball "https://github.com/ymatsiuk/awsvpnclient/archive/master.tar.gz";
    awsvpnclient = pkgs.callPackage "${awsvpnclientRepo}/awsvpnclient.nix" {
        openvpn = pkgs.callPackage "${awsvpnclientRepo}/openvpn.nix" {};
    };
    haskell = pkgs.haskell;
    postgrestPackages = haskell.packages.ghc910.override {
        overrides = self: super: rec {
            fuzzyset = haskell.lib.doJailbreak (haskell.lib.markUnbroken super.fuzzyset);
            configurator-pg = haskell.lib.doJailbreak (haskell.lib.markUnbroken super.configurator-pg);
            hasql-pool = haskell.lib.dontCheck (self.callHackage "hasql-pool" "0.10" {});
            postgrest = haskell.lib.dontCheck (haskell.lib.doJailbreak (
                self.callCabal2nix "postgrest" (
                    builtins.fetchTarball "https://github.com/PostgREST/postgrest/archive/refs/tags/v11.2.1.tar.gz"
                ) {}
            ));
        };
    };
    postgrest = postgrestPackages.postgrest;
in with pkgs; [
    autossh
    awsvpnclient
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
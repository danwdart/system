{
    allowUnfree = true;
    substituters = [
      https://cache.nixos.org
      https://dandart.cachix.org
      https://nixcache.reflex-frp.org
      https://nixcache.webghc.org
      # https://hydra.iohk.io # dead?
      https://static-haskell-nix.cachix.org
    ];
    trusted-substituters = [
      https://cache.nixos.org
      https://dandart.cachix.org
      https://nixcache.reflex-frp.org
      https://nixcache.webghc.org
      https://cache.iog.io
      https://static-haskell-nix.cachix.org
    ];
    trusted-public-keys = [
      cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
      ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=
      hydra.webghc.org-1:knW30Yb8EXYxmUZKEl0Vc6t2BDjAUQ5kfC1BKJ9qEG8=
      hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=
      static-haskell-nix.cachix.org-1:Q17HawmAwaM1/BfIxaEDKAxwTOyRVhPG5Ji9K3+FvUU=
    ];
    # allowBroken = true;
    programs.ssh = {
      knownHosts = {
        github = {
          hostNames = [
            "github.com"
          ];
          publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==";
        };
      };
    };
  }
{...}:
{
  autoOptimiseStore = true;

  binaryCaches = [
    "https://cache.nixos.org"
    "https://nixcache.reflex-frp.org"
    "https://nixcache.webghc.org"
    "https://hydra.iohk.io"    
  ];

  binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    "hydra.webghc.org-1:knW30Yb8EXYxmUZKEl0Vc6t2BDjAUQ5kfC1BKJ9qEG8="
    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
  ];

  trustedUsers = [ "root" "dwd" ];

  gc = {
    automatic = true; # true
    options = "-d";
    dates = "weekly"; # "03:15"
    persistent = true; # like anacron
  };

  extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  optimise = {
    automatic = true;
  };

  systemFeatures = [
     "kvm"
     "big-parallel"
     "gccarch-haswell"
  ];
}
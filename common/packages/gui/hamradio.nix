pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
    pkgsMaster = import (builtins.fetchTarball 
        "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.tar.gz"
    ) {};
    # pkgsIllDefinedFreeDVPre = import (builtins.fetchTarball 
    #     "https://github.com/illdefined/nixpkgs/archive/refs/heads/freedv-pre.tar.gz"
    # ) {};
in
with pkgs; [
    pkgsMaster.chirp
    # cqrlog # github broken?
    cubicsdr
    dabtools
    dfu-util
    direwolf
    fldigi
    freedv
    # pkgsIllDefinedFreeDVPre.freedv_pre
    # gnss-sdr
    # gnuradio # thrift-0.20.0 not supported for interpreter python3.12
    gpredict
    gqrx
    # guglielmo
    hackrf
    # inspectrum # 1 dependencies of derivation '/nix/store/k5r8bpbplh1kl5ffc3qcvzi955l81191-inspectrum-0.3.1.drv' failed to build
    kalibrate-hackrf
    nrsc5
    qsstv
    # quisk # build failure but why build
    # tqsl # openssl too old now
    # rtlsdr
    sdrangel # has to be built now for some reason
    soapyhackrf
    soapysdr-with-plugins
    tqsl
    wsjtx
    xlog
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    flrig
    # soapysdrplay
    # welle-io
] else [
   # pkgs-x86_64.flrig
    ## pkgs-x86_64.soapysdrplay
   # pkgs-x86_64.welle-io
])

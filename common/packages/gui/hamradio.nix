pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    chirp # python issues
    # cqrlog # github broken?
    cubicsdr
    dabtools
    dfu-util
    direwolf # compilation issues?
    fldigi
    freedv
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

pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    chirp
    # cqrlog # github broken?
    cubicsdr
    dabtools
    dfu-util
    # direwolf # compilation issues?
    fldigi
    freedv
    # gnss-sdr
    gnuradio
    gpredict
    gqrx
    # guglielmo
    hackrf
    inspectrum
    kalibrate-hackrf
    nrsc5
    qsstv
    # quisk # build failure but why build
    # tqsl # openssl too old now
    # rtlsdr
    sdrangel # has to be built now for some reason
    soapyhackrf
    soapysdr-with-plugins
    soundmodem # no desktop icon, needs config
    wsjtx
    xlog
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    flrig
    soapysdrplay
    welle-io
] else [
    pkgs-x86_64.flrig
    # pkgs-x86_64.soapysdrplay
    pkgs-x86_64.welle-io
])

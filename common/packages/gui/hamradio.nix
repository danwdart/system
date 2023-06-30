pkgs:
with pkgs; [
    chirp
    cqrlog
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
    tqsl
    # rtlsdr
    sdrangel
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
])

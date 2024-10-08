pkgs:
with pkgs;
[
    a2jmidid # CLI
    AMB-plugins
    ardour
    audacity
    autotalent
    # baudline # download link is down
    caps
    clementine
    csa
    faust2ladspa
    fluidsynth
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    helvum # like qjackctl but lines
    hydrogen
    # ingen # build failed with raul-unstable
    jack_rack
    kapitonov-plugins-pack
    nova-filters
    pavucontrol
    qjackctl # the other one?
    qsynth
    rosegarden
    soundfont-fluid
    yoshimi
    zam-plugins
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    bristol # no desktop icon
    plugin-torture # broken on aarch64
    polyphone # no desktop icon # broken on aarch64
    tuxguitar # no desktop icon # REALLY broken on aarch64
    x42-gmsynth # broken on aarch64
] else [
])

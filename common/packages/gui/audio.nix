pkgs:
with pkgs;
[
    a2jmidid # CLI
    AMB-plugins
    # ardour # can't build raptor
    # audacity # rapidjson problem
    autotalent
    # baudline # download link is down
    # carla # also a plugin host # can't build python3.12-pyliblo # cython-0.29.37.1 not supported for interpreter python3.13
    caps
    clementine
    csa
    faust2ladspa
    fluidsynth
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    helvum # like qjackctl but lines and also what gladish was
    hydrogen
    # ingen # build failed with raul-unstable
    # jack_rack # won't build
    kapitonov-plugins-pack
    # nova-filters # includes jack-rack?
    pavucontrol
    picard
    # qarecord # TODO request
    qjackctl # the other one?
    qsynth
    # rosegarden # dssi fails to build
    soundfont-fluid
    yoshimi
    zam-plugins
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # bristol # no desktop icon # can't compile
    plugin-torture # broken on aarch64
    polyphone # no desktop icon # broken on aarch64
    tuxguitar # no desktop icon # REALLY broken on aarch64
    x42-gmsynth # broken on aarch64
] else [
])

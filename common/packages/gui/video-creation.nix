pkgs:
with pkgs; [
    # avidemux # fails to build
    # cinelerra # keeps compiling # too big for now
    flowblade
    kdePackages.kdenlive
    lightworks
    simplescreenrecorder
    obs-studio
    olive-editor
    # openshot-qt # no qtwebengine
    # pitivi # requires triton-llvm which takes 10 years and 100 GB of RAM to build
    # shotcut # won't build because of jack1
]
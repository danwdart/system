pkgs:
with pkgs; [
    betterdiscordctl
    (discord.override {
        withOpenASAR = true;
        nss = pkgs.nss_latest;
    })
    element-desktop
    skypeforlinux
    slack
    zoom-us
]
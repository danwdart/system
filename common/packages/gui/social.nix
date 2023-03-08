pkgs:
with pkgs; [
    element-desktop
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    betterdiscordctl
    (discord.override {
        withOpenASAR = true;
        nss = pkgs.nss_latest;
    })
    skypeforlinux
    slack
    zoom-us
] else [
])

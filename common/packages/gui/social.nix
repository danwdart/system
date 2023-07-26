pkgs:
let
    pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    element-desktop
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    betterdiscordctl
    (discord.override {
        withOpenASAR = true;
        nss = pkgs.nss_latest;
    })
    skypeforlinux
] else [
    pkgs-x86_64.betterdiscordctl
    (pkgs-x86_64.discord.override {
        withOpenASAR = true;
        nss = pkgs-x86_64.nss_latest;
    })
    pkgs-x86_64.skypeforlinux
])

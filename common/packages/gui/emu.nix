{ pkgs, unstable, ... }:
with pkgs; [
    desmume
    dosbox
    # epsxe # insecure openssl
    higan
    melonDS
    # pcsxr # depends on insecure ffmpeg
    #protontricks
    rpcs3
    # ruffle
    virt-viewer
    # winePackages.fonts
    # master.winePackages.staging
    # winetricks # depend on correct version
    #(unstable.winetricks.override {
    #    wine = unstable.wineWowPackages.staging;
    #})
    wiiload
    wiimms-iso-tools
    wiiuse
    winetricks
    # master.yuzu
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    citra # broken on aarch64
    pcsx2 # keeps recompiling
    retroarchFull # TODO: get rid of libretro-parallel-n64-code - that's the one that's broken on aarch64
    unstable.wineWowPackages.fonts
    # master.wineWowPackages.staging # takes forever to compile
    unstable.wineWowPackages.staging
] else [
])


{ pkgs, unstable, ... }:
with pkgs; [
    desmume
    dosbox
    citra
    # epsxe # insecure openssl
    higan
    retroarchFull
    melonDS
    pcsx2 # keeps recompiling
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
    unstable.wineWowPackages.fonts
    # master.wineWowPackages.staging # takes forever to compile
    unstable.wineWowPackages.staging
    wiiload
    wiimms-iso-tools
    wiiuse
    winetricks
    # master.yuzu
]

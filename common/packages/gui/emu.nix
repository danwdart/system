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
    ruffle
    # winePackages.fonts
    # master.winePackages.staging
    # winetricks # depend on correct version
    #(unstable.winetricks.override {
    #    wine = unstable.wineWowPackages.staging;
    #})
    unstable.wineWowPackages.fonts # stable = 6.2, unstable = 7
    # master.wineWowPackages.staging # takes forever to compile
    unstable.wineWowPackages.staging # stable = 6.2, unstable = 7
    wiiload
    wiimms-iso-tools
    wiiuse
    # master.yuzu
]
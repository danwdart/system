{ pkgs, master, ... }:
with pkgs; [
    desmume
    dosbox
    citra
    # epsxe # insecure openssl
    higan
    melonDS
    pcsx2 # keeps recompiling
    # pcsxr # depends on insecure ffmpeg
    #protontricks
    rpcs3
    ruffle
    #unstable.winePackages.fonts
    # master.winePackages.staging
    # unstable.winetricks # depend on correct version
    #unstable.wineWowPackages.fonts
    master.wineWowPackages.staging
    wiiload
    wiimms-iso-tools
    wiiuse
    # master.yuzu
]
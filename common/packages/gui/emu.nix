{ pkgs, master, ... }:
with pkgs; [
    dosbox
    pcsx2 # keeps recompiling
    # pcsxr # depends on insecure ffmpeg
    #protontricks
    #unstable.winePackages.fonts
    # master.winePackages.staging
    # unstable.winetricks # depend on correct version
    #unstable.wineWowPackages.fonts
    master.wineWowPackages.staging
    wiiload
    wiimms-iso-tools
    wiiuse
]
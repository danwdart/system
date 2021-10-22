{ pkgs, master, ... }:
with pkgs; [
    dosbox
    #protontricks
    #unstable.winePackages.fonts
    master.winePackages.staging
    # unstable.winetricks # depend on correct version
    #unstable.wineWowPackages.fonts
    master.wineWowPackages.staging
]
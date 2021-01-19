{ pkgs, ... }:
with pkgs; [
    dosbox
    mtools
    protontricks
    winePackages.fonts
    winePackages.staging
    winetricks
    wineWowPackages.fonts
    wineWowPackages.staging
]
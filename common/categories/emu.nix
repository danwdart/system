{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    dosbox
    mtools
    protontricks
    unstable.winePackages.fonts
    unstable.winePackages.staging
    unstable.winetricks
    unstable.wineWowPackages.fonts
    unstable.wineWowPackages.staging
]
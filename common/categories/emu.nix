{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    dosbox
    mtools
    protontricks
    #unstable.winePackages.fonts
    #unstable.winePackages.staging
    # unstable.winetricks # depend on correct version
    unstable.wineWowPackages.fonts
    unstable.wineWowPackages.staging
]
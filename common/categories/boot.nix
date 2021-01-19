{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    unstable.beefi
    efibootmgr
    efitools
    efivar
    gptfdisk
    sbsigntool
    uefi-firmware-parser
    uefitool
    uefitoolPackages.new-engine
    uefitoolPackages.old-engine
]
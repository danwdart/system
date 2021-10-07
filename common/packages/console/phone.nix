{ pkgs, unstable, ... }:
with pkgs; [
    atinout
    gammu # CLI, needs wammu but doesn't exist
    lrzsz # dep
    minicom
    mnemonicode
    unstable.androidenv.androidPkgs_9_0.platform-tools # possibly unneeded, possibly fastboot
    statserial
    zssh
]
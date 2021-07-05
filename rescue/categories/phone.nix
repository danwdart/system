{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    atinout
    calls
    gammu # CLI, needs wammu but doesn't exist
    # gnokii - broken
    lrzsz # dep
    minicom
    mnemonicode
    ofono-phonesim
    unstable.androidenv.androidPkgs_9_0.platform-tools # possibly unneeded, possibly fastboot
    statserial
    # wammu - does not exist
    zssh
]
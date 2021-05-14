{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    atinout
    calls
    gammu
    # gnokii - broken
    lrzsz
    minicom
    mnemonicode
    ofono-phonesim
    unstable.androidenv.androidPkgs_9_0.platform-tools
    statserial
    # wammu - does not exist
    zssh
]
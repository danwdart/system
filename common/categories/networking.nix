{ pkgs, ... }:
with pkgs; [
    doctl # run doctl auth init before use
    ipfs
    irssi
    mailutils
    putty # no desktop icon
    rdesktop
    scrcpy
    tightvnc
    torbrowser
]
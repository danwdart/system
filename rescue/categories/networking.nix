{ pkgs, ... }:
with pkgs; [
    bind # host, nslookup etc
    doctl # run doctl auth init before use
    ipfs
    irssi
    mailutils
    putty # no desktop icon
    rdesktop # no gui without config
    scrcpy
    tightvnc # no gui without config
    torbrowser
]
{ pkgs, ... }:
with pkgs; [
    nextcloud-client
    putty # no desktop icon
    rdesktop # no gui without config
    scrcpy
    tightvnc # no gui without config
    tor-browser-bundle-bin
]
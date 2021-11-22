{ pkgs, master, ... }:
with pkgs; [
    nextcloud-client
    putty # no desktop icon
    rdesktop # no gui without config
    master.scrcpy
    tightvnc # no gui without config
    tor-browser-bundle-bin
]
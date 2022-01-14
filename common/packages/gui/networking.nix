{ pkgs, master, ... }:
with pkgs; [
    etherape
    insomnia
    nextcloud-client
    postman
    putty # no desktop icon
    rdesktop # no gui without config
    master.scrcpy
    newman
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    tor-browser-bundle-bin
    wireshark
]
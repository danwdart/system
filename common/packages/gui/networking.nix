{ pkgs, unstable, ... }:
with pkgs; [
    etherape
    insomnia
    nextcloud-client
    postman
    putty # no desktop icon
    rdesktop # no gui without config
    unstable.scrcpy # stable = 1.20, unstable = 1.21, master = 1.22
    newman
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    tor-browser-bundle-bin
    wireshark
]
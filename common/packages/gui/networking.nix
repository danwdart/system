{ pkgs, unstable, ... }:
with pkgs; [
    beekeeper-studio # for work, TODO split out?
    dbeaver # for work, TODO split out?
    etherape
    insomnia
    # mysql-workbench # for work, TODO split out? # error: pynacl-1.4.0 not supported for interpreter python2.7
    nextcloud-client
    postman
    putty # no desktop icon
    rdesktop # no gui without config
    unstable.scrcpy # stable = 1.20, unstable = 1.21, master = 1.22
    newman
    protonvpn-gui
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    tor-browser-bundle-bin
    wireshark
]
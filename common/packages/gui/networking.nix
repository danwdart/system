{ pkgs, unstable, ... }:
with pkgs; [
    dbeaver # for work, TODO split out?
    etherape
    # mysql-workbench # for work, TODO split out? # error: pynacl-1.4.0 not supported for interpreter python2.7
    networkmanager-openvpn
    nextcloud-client
    putty # no desktop icon
    rdesktop # no gui without config
    newman
    protonvpn-gui
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    wireshark
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    beekeeper-studio # for work, TODO split out?
    insomnia
    postman
    unstable.scrcpy # stable = 1.20, unstable = 1.21, master = 1.22
    tor-browser-bundle-bin
] else [
])

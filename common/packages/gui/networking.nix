pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
    pkgsMaster = import (builtins.fetchTarball 
        "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.tar.gz"
    ) {};
in
with pkgs; [
    pkgsMaster.dbeaver-bin # for work, TODO split out?
    etherape
    mysql-workbench
    networkmanager-openvpn
    nextcloud-client
    putty # no desktop icon
    rdesktop # no gui without config
    newman
    # protonvpn-gui
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    wireshark
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # beekeeper-studio # for work, TODO split out?
    insomnia
    # postman
    scrcpy
    tor-browser-bundle-bin
] else [
   # pkgs-x86_64.insomnia
   # pkgs-x86_64.postman
   # pkgs-x86_64.scrcpy
   # pkgs-x86_64.tor-browser-bundle-bin
])

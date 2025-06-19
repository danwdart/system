pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    dbeaver-bin
    # etherape # failed to build goocanvas
    # mysql-workbench
    networkmanager-openvpn
    nextcloud-client
    putty # no desktop icon
    # rdesktop # no gui without config # fails to build
    # newman
    # protonvpn-gui
    # tightvnc # no gui without config # banned as insecure with no replacement suggested
    wireshark
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # beekeeper-studio # for work, TODO split out?
    # insomnia
    # postman
    scrcpy
    tor-browser-bundle-bin
] else [
   # pkgs-x86_64.insomnia
   # pkgs-x86_64.postman
   # pkgs-x86_64.scrcpy
   # pkgs-x86_64.tor-browser-bundle-bin
])

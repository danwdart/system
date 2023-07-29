pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
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
    scrcpy
    tor-browser-bundle-bin
] else [
    pkgs-x86_64.beekeeper-studio # for work, TODO split out?
    pkgs-x86_64.insomnia
    pkgs-x86_64.postman
    pkgs-x86_64.scrcpy
    pkgs-x86_64.tor-browser-bundle-bin
])

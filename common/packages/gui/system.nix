let
    pkgsMaster = import (builtins.fetchTarball 
        "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.tar.gz"
    ) {};
in
pkgs:
with pkgs; [
    alacritty
    clamtk
    #etcher
    pkgsMaster.ghostty
    gparted
    kitty
    #rpi-imager
    stacer
    #unetbootin
    wev
    #winusb
    #woeusb # -ng
    #xcruiser # no desktop icon
    #xorg.xev
    systembus-notify # make it autostart?
    testdisk-qt
    timeshift
    turbovnc # from tightvnc
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # xorg.xf86videointel
] else [
])

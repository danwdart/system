let
    pkgsMaster = import (builtins.fetchTarball 
        "https://github.com/NixOS/nixpkgs/archive/refs/heads/master.tar.gz"
    ) {};
in
pkgs:
with pkgs; [
    alacritty
    cascadia-code
    clamtk
    #etcher
    pkgsMaster.ghostty
    gparted
    iosevka
    kitty
    # nerd-fonts.STUFFGOESHERE
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
    unifont
    unifont-csur
    unifont_upper
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # xorg.xf86videointel
] else [
])

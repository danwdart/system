pkgs:
with pkgs; [
    #etcher
    gparted
    #rpi-imager
    #unetbootin
    #winusb
    #woeusb
    #xcruiser # no desktop icon
    #xorg.xev
    systembus-notify # make it autostart?
    testdisk-qt
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    xorg.xf86videointel
] else [
])

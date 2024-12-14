pkgs:
with pkgs; [
    #etcher
    gparted
    kitty
    #rpi-imager
    #unetbootin
    wev
    #winusb
    #woeusb # -ng
    #xcruiser # no desktop icon
    #xorg.xev
    systembus-notify # make it autostart?
    testdisk-qt
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    xorg.xf86videointel
] else [
])

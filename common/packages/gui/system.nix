{ pkgs, unstable, ... }:
with pkgs; [
    #etcher
    gparted
    #unstable.rpi-imager
    #unetbootin
    #winusb
    #woeusb
    #xcruiser # no desktop icon
    #xorg.xev
    xorg.xf86videointel
]
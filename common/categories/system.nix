{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    etcher
    file
    f3
    glances
    hdparm
    htop
    iotop
    inetutils
    jnettop
    lm_sensors
    lshw
    ncdu
    networkmanager
    p7zip
    pciutils
    unstable.rpi-imager
    socat
    unzip
    usbutils
    wget
    xcruiser
    xorg.xev
    xorg.xf86videointel
]
{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    etcher
    file
    f3
    glances
    gparted
    gptfdisk
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
    partition-manager
    pciutils
    unstable.rpi-imager
    socat
    unetbootin
    unzip
    usbutils
    wget
    xcruiser
    xorg.xev
    xorg.xf86videointel
]
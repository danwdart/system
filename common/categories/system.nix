{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    cdrkit
    cdrtools
    cmatrix
    enhanced-ctorrent
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
    multibootusb # broken GUI
    ncdu
    networkmanager
    opencorsairlink
    p7zip
    partition-manager
    pciutils
    rpiboot-unstable
    unstable.rpi-imager
    sixpair
    socat
    u3-tool
    unetbootin
    unzip
    usbguard
    usbutils
    wget
    winusb
    woeusb
    xcruiser # no desktop icon
    xorg.xev
    xorg.xf86videointel
]
{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    cdrkit
    cdrtools
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
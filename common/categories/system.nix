{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    bluez-alsa
    bluez-tools
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
    hidapi
    htop
    i7z
    inetutils
    jnettop
    lm_sensors
    lshw
    # multibootusb # broken GUI, also broken
    ncdu
    networkmanager # possibly unneeded
    obexfs
    obexftp
    unstable.opencorsairlink
    p7zip
    pciutils
    rpiboot-unstable
    unstable.rpi-imager
    sixpair
    socat
    u3-tool
    unetbootin
    unzip
    usbutils
    wget
    winusb
    woeusb
    xcruiser # no desktop icon
    xorg.xev
    xorg.xf86videointel
]
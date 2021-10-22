{ pkgs, unstable, ... }:
with pkgs; [
    bluez-alsa
    bluez-tools
    cdrkit
    cdrtools
    cmatrix
    enhanced-ctorrent
    file
    f3
    glances
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
    sixpair
    socat
    u3-tool
    unrar
    unzip
    usbutils
    wget
]
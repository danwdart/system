pkgs:
with pkgs; [
    aha # for formatting the output of the firmware section of the Info Centre
    bluez-alsa
    bluez-tools
    cdrkit
    cdrtools
    clinfo
    cmatrix
    egl-wayland
    enhanced-ctorrent
    file
    # f3 # doesn't compile due to libudev.h missing
    glances
    glxinfo
    gptfdisk
    hdparm
    hidapi
    htop
    inetutils
    jmtpfs
    jnettop
    kexec-tools
    lm_sensors
    lshw
    lsof
    mono
    # multibootusb # broken GUI, also broken
    ncdu
    networkmanager # possibly unneeded
    ntfs3g
    obexfs
    obexftp
    # opencorsairlink
    p7zip
    pciutils
    rpiboot
    sixpair
    socat
    testdisk
    vulkan-tools
    u3-tool
    unrar
    unzip
    usbutils
    ventoy-bin
    wget
    wirelesstools
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    i7z
] else [
])

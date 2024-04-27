pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
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
    # htop # dealt with
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
    # screen # dealt with
    sixpair
    socat
    testdisk
    u3-tool
    unrar
    unzip
    usbutils
    ventoy
    vulkan-tools
    wayland-utils
    wget
    wirelesstools
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    i7z
] else [
   # pkgs-x86_64.i7z
])

pkgs:
with pkgs; [
    atinout
    gammu # CLI, needs wammu but doesn't exist
    heimdall
    idevicerestore
    ideviceinstaller
    ifuse
    ipatool
    libideviceactivation
    libirecovery
    lrzsz # dep
    minicom
    mnemonicode
    # androidenv.androidPkgs_9_0.platform-tools # possibly unneeded, possibly fastboot # build failure
    statserial
    xpwn
    zssh
]
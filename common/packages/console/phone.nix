pkgs:
with pkgs; [
    atinout
    gammu # CLI, needs wammu but doesn't exist
    heimdall
    # idevicerestore # error: builder for '/nix/store/ipq996c0kad95bky98nqdqvhvpnmkhsg-libirecovery-1.2.1.drv' failed with exit code 1
    ideviceinstaller
    ifuse
    ipatool
    libideviceactivation
    # libirecovery # error: builder for '/nix/store/ipq996c0kad95bky98nqdqvhvpnmkhsg-libirecovery-1.2.1.drv' failed with exit code 1
    # lrzsz # dep # won't compile
    minicom # no lrzsz
    mnemonicode
    # androidenv.androidPkgs_9_0.platform-tools # possibly unneeded, possibly fastboot # build failure
    statserial
    # xpwn # failed to build in minizip
    # zssh # failed to build
]
pkgs:
with pkgs; [
    alacritty
    cascadia-code
    clamtk
    #etcher
    ghostty
    gparted
    iosevka
    kitty
    linux-exploit-suggester
    linux-wallpaperengine
    # nerd-fonts.STUFFGOESHERE
    #rpi-imager
    stacer
    #unetbootin
    wev
    #winusb
    #woeusb # -ng
    wsysmon
    #xcruiser # no desktop icon
    #xorg.xev
    systembus-notify # make it autostart?
    testdisk-qt
    timeshift
    turbovnc # from tightvnc
    unifont
    unifont-csur
    unifont_upper
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # xorg.xf86videointel
] else [
])

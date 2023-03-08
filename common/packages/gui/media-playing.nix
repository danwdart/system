pkgs:
with pkgs; [
    # clementine
    # clementineUnfree # needs building?
    #ffmpeg-full #insecure for now
    vlc
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    mplayer
    spotify
    spotifywm
] else [
])

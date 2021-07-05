{ pkgs, ... }:
with pkgs; [
    # clementine
    # clementineUnfree # needs building?
    #ffmpeg-full #insecure for now
    mplayer
    ncspot
    spotify
    spotifywm
    vlc
]
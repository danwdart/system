{ pkgs, ... }:
with pkgs; [
    # clementine
    # clementineUnfree # needs building?
    ffmpeg-full
    mplayer
    ncspot
    spotify
    spotifywm
    vlc
]
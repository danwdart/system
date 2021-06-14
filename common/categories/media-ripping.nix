{ pkgs, ... }:
with pkgs; [
    gnome3.cheese
    get_iplayer
    python38Packages.internetarchive # ia binary
    tartube
    # tvheadend # ffmpeg too old
    youtube-dl
]
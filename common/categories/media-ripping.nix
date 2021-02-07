{ pkgs, ... }:
with pkgs; [
    gnome3.cheese
    get_iplayer
    python38Packages.internetarchive
    tartube
    tvheadend
    youtube-dl
]
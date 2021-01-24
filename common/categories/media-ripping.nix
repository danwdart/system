{ pkgs, ... }:
with pkgs; [
    get_iplayer
    python38Packages.internetarchive
    tartube
    tvheadend
    youtube-dl
]
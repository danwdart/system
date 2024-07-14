pkgs:
with pkgs; [
    get_iplayer
    # python313Packages.internetarchive # ia binary # unneeded much, also breaks
    # tvheadend # ffmpeg too old
    yt-dlp
]
pkgs:
with pkgs; [
    get_iplayer
    # python312Packages.internetarchive # ia binary # unneeded much, also breaks
    # tvheadend # ffmpeg too old
    youtube-dl
    yt-dlp
]
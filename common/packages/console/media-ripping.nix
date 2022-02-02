pkgs:
with pkgs; [
    get_iplayer
    python38Packages.internetarchive # ia binary
    # tvheadend # ffmpeg too old
    youtube-dl
    yt-dlp
]
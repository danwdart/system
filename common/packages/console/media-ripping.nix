pkgs:
with pkgs; [
    get_iplayer
    # python314Packages.internetarchive # ia binary # unneeded much, also breaks in pytest_mock
    # tvheadend # ffmpeg too old - unmaintained now - https://github.com/NixOS/nixpkgs/pull/332259
    yt-dlp
]
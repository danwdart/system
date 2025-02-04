pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    clementine
    # clementineUnfree # needs building?
    #ffmpeg-full #insecure for now
    kaffeine
    vlc
    gnome-network-displays
    guvcview
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # mplayer # no longer builds
    spotify
    spotifywm
] else [
   # pkgs-x86_64.mplayer
   # pkgs-x86_64.spotify
   # pkgs-x86_64.spotifywm
])

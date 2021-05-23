{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    armagetronad # no desktop icon
    bsdgames
    dolphinEmu
    extremetuxracer
    frozen-bubble # check for dtop
    ioquake3 # no desktop icon
    # lbreakout2
    ltris
    # mgba
    mupen64plus # no desktop icon
    nethack-qt # no desktop icon
    # nexuiz # no desktop icon # BIG
    # openarena # no desktop icon # BIG
    # padman?
    # pcsx2 # keeps recompiling
    # pcsxr # depends on insecure ffmpeg
    quake3e # no desktop icon
    quakespasm # no desktop icon
    #redeclipse
    #sauerbraten # no desktop icon
    snes9x-gtk
    # speed_dreams # no desktop icon # keeps compiling
    steam
    steamcmd
    steam-run-native
    #stuntrally # BIG
    #superTux # Bigish
    #superTuxKart # BIG
    # torcs # no desktop icon
    # tremulous - broken
    #trigger # no desktop icon
    # unstable.uhexen2 - soon
    # urbanterror # no desktop icon # nBIG
    vkquake
    # warsow - can't download
    #xonotic # keeps compiling
    yquake2 # no desktop icon
    zsnes
]

{ pkgs, unstable, master, ... }:
with pkgs; [
    armagetronad # no desktop icon
    master.dolphinEmu
    # extremetuxracer
    # frozen-bubble
    golly
    hhexen
    ioquake3 # no desktop icon
    # lbreakout2
    # ltris
    # mgba
    # mupen64plus # no desktop icon
    # nethack-qt # no desktop icon
    # nexuiz # no desktop icon # BIG
    # openarena # no desktop icon # BIG
    # padman?
    quake3e # no desktop icon
    quakespasm # no desktop icon
    # redeclipse
    # sauerbraten # no desktop icon
    # snes9x-gtk # has to compile now?
    # speed_dreams # no desktop icon # keeps compiling
    steam
    steamcmd
    steam-run-native
    # stuntrally # BIG
    # superTux # Bigish
    # superTuxKart # BIG
    # torcs # no desktop icon
    # tremulous - broken
    # trigger # no desktop icon
    uhexen2
    # urbanterror # no desktop icon # nBIG
    vkquake # no desktop icon but needs dir
    # warsow - can't download
    # xonotic # keeps compiling
    yquake2 # no desktop icon
    # zsnes
]

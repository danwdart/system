pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    # armagetronad # no desktop icon # failed with exit code 141
    dolphinEmu
    # extremetuxracer
    # frozen-bubble
    # golly # now broken?
    hhexen
    ioquake3 # no desktop icon
    # lbreakout2
    liberation-circuit
    # ltris
    megaglest
    # mgba
    # mupen64plus # no desktop icon
    nethack-qt # no desktop icon
    # nexuiz # no desktop icon # BIG
    # openarena # no desktop icon # BIG
    # padman?
    quakespasm # no desktop icon
    # redeclipse
    # sauerbraten # no desktop icon
    # snes9x-gtk # has to compile now?
    # speed_dreams # no desktop icon # keeps compiling
    # stuntrally # BIG
    # superTux # Bigish
    superTuxKart # BIG
    # torcs # no desktop icon
    # tremulous - broken
    # trigger # no desktop icon
    uhexen2
    # urbanterror # no desktop icon # nBIG
    # warsow - can't download
    # xonotic # keeps compiling
    yquake2 # no desktop icon
    # zeroadPackages.zeroad-unwrapped # segfaults
    # zeroadPackages.zeroad-data
    # zsnes
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    steam
    steamcmd
    steam-run-native
    quake3e # no desktop icon
    vkquake # no desktop icon but needs dir
] else [
   # pkgs-x86_64.quake3e # no desktop icon
   # pkgs-x86_64.vkquake # no desktop icon but needs dir
])

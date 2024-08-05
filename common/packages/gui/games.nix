pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
    pkgs-doomsday = import (builtins.fetchTarball "https://github.com/pluiedev/nixpkgs/archive/refs/heads/init/doomsday-engine.tar.gz") {
    };
in
with pkgs; [
    # alienarena # no desktop icon # segfaults
    # armagetronad # no desktop icon # failed with exit code 141
    dolphinEmu
    pkgs-doomsday.doomsday-engine3
    # extremetuxracer
    # frozen-bubble
    # golly # now broken?
    hhexen
    ioquake3
    # lbreakout2
    # liberation-circuit # no desktop icon # wat
    # ltris
    # megaglest # more like meh-a-glest
    # mgba
    # mupen64plus # no desktop icon
    nethack-qt # no desktop icon
    nexuiz # no desktop icon # BIG
    openarena # no desktop icon # BIG
    # padman?
    # quakespasm # no desktop icon
    # redeclipse # meh crazy controls now?
    sauerbraten # split into console/gui?
    # snes9x-gtk # has to compile now?
    # speed_dreams # no desktop icon # keeps compiling
    # stuntrally # BIG
    # superTux # Bigish
    # superTuxKart # BIG
    # torcs # no desktop icon
    # tremulous # - broken
    # trenchbroom
    # trigger # no desktop icon
    uhexen2
    # urbanterror # BIG # weirdX
    # warsow # ehh... no desktop icon
    xonotic
    yquake2
    # zeroadPackages.zeroad-unwrapped # segfaults
    # zeroadPackages.zeroad-data
    # zsnes
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    steam
    steamcmd
    steam-run-native
    quake3e
    # vkquake # no desktop icon but needs dir
] else [
   # pkgs-x86_64.quake3e # no desktop icon
   # pkgs-x86_64.vkquake # no desktop icon but needs dir
])

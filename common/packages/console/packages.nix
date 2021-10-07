{ pkgs, unstable, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
# @TODO wildcard
    ++ import ./backup.nix pkgs
    ++ import ./boot.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./code.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./emu.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./fun.nix pkgs
    ++ import ./games.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./hamradio.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./maths.nix pkgs
    ++ import ./media-playing.nix pkgs
    ++ import ./media-ripping.nix pkgs
    ++ import ./networking.nix pkgs
    ++ import ./nix.nix pkgs
    ++ import ./phone.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./security.nix pkgs
    ++ import ./system.nix {pkgs = pkgs; unstable = unstable;}

pkgs:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
# @TODO wildcard
    ++ import ./backup.nix pkgs
    ++ import ./boot.nix pkgs
    ++ import ./code.nix pkgs
    ++ import ./emu.nix pkgs
    ++ import ./fun.nix pkgs
    ++ import ./games.nix pkgs
    ++ import ./hamradio.nix pkgs
    ++ import ./maths.nix pkgs
    ++ import ./media-playing.nix pkgs
    ++ import ./media-ripping.nix pkgs
    ++ import ./networking.nix pkgs
    ++ import ./nix.nix pkgs
    ++ import ./phone.nix pkgs
    ++ import ./security.nix pkgs
    ++ import ./system.nix pkgs

{ pkgs, unstable, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
# @TODO wildcard
    ++ import ./astronomy.nix pkgs
    ++ import ./audio.nix pkgs
    ++ import ./backup.nix pkgs
    ++ import ./browser.nix pkgs
    ++ import ./chemistry.nix pkgs
    ++ import ./code.nix pkgs
    ++ import ./email.nix pkgs
    ++ import ./emu.nix {pkgs = pkgs; unstable = unstable; }
    ++ import ./encryption.nix pkgs
    ++ import ./games.nix pkgs
    ++ import ./genealogy.nix pkgs
    ++ import ./graphics.nix pkgs
    ++ import ./hamradio.nix pkgs
    ++ import ./health.nix pkgs
    ++ import ./kde.nix pkgs
    ++ import ./media-playing.nix pkgs
    ++ import ./media-ripping.nix pkgs
    ++ import ./networking.nix {pkgs = pkgs; unstable = unstable; }
    ++ import ./office.nix pkgs
    ++ import ./phone.nix pkgs
    ++ import ./security.nix pkgs
    ++ import ./social.nix pkgs
    ++ import ./system.nix pkgs
    ++ import ./toys.nix pkgs
    ++ import ./video-creation.nix pkgs

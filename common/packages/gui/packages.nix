{ pkgs, unstable, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
# @TODO wildcard
    ++ import ./astronomy.nix pkgs
    ++ import ./audio.nix pkgs
    ++ import ./backup.nix pkgs
    ++ import ./browser.nix pkgs
    ++ import ./chemistry.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./code.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./email.nix pkgs
    ++ import ./emu.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./encryption.nix pkgs
    ++ import ./games.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./genealogy.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./graphics.nix pkgs
    ++ import ./hamradio.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./health.nix pkgs
    ++ import ./kde.nix pkgs
    ++ import ./media-playing.nix pkgs
    ++ import ./media-ripping.nix pkgs
    ++ import ./networking.nix pkgs
    ++ import ./office.nix pkgs
    ++ import ./phone.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./social.nix pkgs
    ++ import ./system.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./video-creation.nix pkgs

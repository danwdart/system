{ pkgs, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
    ++ import ./categories/astronomy.nix pkgs
    ++ import ./categories/audio.nix pkgs
    ++ import ./categories/backup.nix pkgs
    ++ import ./categories/boot.nix pkgs
    ++ import ./categories/browser.nix pkgs
    ++ import ./categories/code.nix pkgs
    ++ import ./categories/email.nix pkgs
    ++ import ./categories/emu.nix pkgs
    ++ import ./categories/encryption.nix pkgs
    ++ import ./categories/fun.nix pkgs
    ++ import ./categories/games.nix pkgs
    ++ import ./categories/graphics.nix pkgs
    ++ import ./categories/hamradio.nix pkgs
    ++ import ./categories/health.nix pkgs
    ++ import ./categories/kde.nix pkgs
    ++ import ./categories/mapping.nix pkgs
    ++ import ./categories/maths.nix pkgs
    ++ import ./categories/media-playing.nix pkgs
    ++ import ./categories/media-ripping.nix pkgs
    ++ import ./categories/networking.nix pkgs
    ++ import ./categories/nix.nix pkgs
    ++ import ./categories/office.nix pkgs
    ++ import ./categories/phone.nix pkgs
    ++ import ./categories/security.nix pkgs
    ++ import ./categories/social.nix pkgs
    ++ import ./categories/system.nix pkgs
    ++ import ./categories/video-creation.nix pkgs
    ++ import ./categories/virt.nix pkgs
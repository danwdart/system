{ pkgs, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
    ++ import ./categories/backup.nix pkgs
    ++ import ./categories/boot.nix pkgs
    ++ import ./categories/browser.nix pkgs
    ++ import ./categories/code.nix pkgs
    ++ import ./categories/encryption.nix pkgs
    ++ import ./categories/fun.nix pkgs
    ++ import ./categories/kde.nix pkgs
    ++ import ./categories/networking.nix pkgs
    ++ import ./categories/nix.nix pkgs
    ++ import ./categories/office.nix pkgs
    ++ import ./categories/security.nix pkgs
    ++ import ./categories/system.nix pkgs
    ++ import ./categories/virt.nix pkgs

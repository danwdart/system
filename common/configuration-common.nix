# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, hostName, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };
  lanzaboote = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/lanzaboote/archive/refs/tags/v0.4.2.tar.gz";
  });
  rootDir = "/home/dwd/code/mine/nix/system";
  hostDir = "${rootDir}/${hostName}";
  privateDir = "${hostDir}/private";
in {
  imports =
    [
      "${home-manager}/nixos"
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
      lanzaboote.nixosModules.lanzaboote
    ];

  boot = import ./boot.nix { pkgs = pkgs; lib = lib; };
  console = import ./console.nix {};
  i18n = import ./i18n.nix {};
  nix = import ./nix.nix { pkgs = pkgs; };
  nixpkgs = import ./nixpkgs.nix {};
  system = import ./system.nix { hostName = hostName; };
  time = import ./time.nix {};
  users = import ./users.nix { privateDir = privateDir; };
  virtualisation = import ./virtualisation.nix {};

  home-manager.backupFileExtension = ".bak";

  # todo move

  # powerManagement.powertop.enable = true; # no because the mouse dies a lot otherwise
}

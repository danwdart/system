# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, hostName, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
  };
  lanzaboote = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/lanzaboote/archive/refs/tags/v0.4.3.tar.gz";
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

  boot = import ./boot.nix { inherit pkgs; inherit lib; };
  console = import ./console.nix {};
  i18n = import ./i18n.nix {};
  nix = import ./nix.nix { inherit pkgs; };
  nixpkgs = import ./nixpkgs.nix {};
  system = import ./system.nix { inherit hostName; };
  time = import ./time.nix {};
  users = import ./users.nix { inherit privateDir; };
  virtualisation = import ./virtualisation.nix {};

  home-manager.backupFileExtension = ".bak";

  # todo move

  # powerManagement.powertop.enable = true; # no because the mouse dies a lot otherwise
}

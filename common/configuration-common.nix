# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, hostName, ... }:
let
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  };
  rootDir = "/home/dwd/code/mine/nix/system";
  hostDir = "${rootDir}/${hostName}";
  privateDir = "${hostDir}/private";
in {
  imports =
    [
      "${home-manager}/nixos"
      (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
    ];

  boot = import ./boot.nix {pkgs = pkgs;};
  console = import ./console.nix {};
  i18n = import ./i18n.nix {};
  networking = import ./networking.nix { lib = lib; hostName = hostName; };
  nix = import ./nix.nix { pkgs = pkgs; };
  nixpkgs = import ./nixpkgs.nix {};
  security = import ./security.nix pkgs;
  sound = import ./sound.nix {};
  system = import ./system.nix { hostName = hostName; };
  systemd = import ./systemd.nix {};
  time = import ./time.nix {};
  users = import ./users.nix { privateDir = privateDir; };
  virtualisation = import ./virtualisation.nix {};

  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # todo move

  powerManagement.powertop.enable = true;
}

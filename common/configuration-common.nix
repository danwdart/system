# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, ... }:
let
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
  #master = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {
  #  config = {
  #    allowUnfree = true;
  #  };
  #};
  home-manager = builtins.fetchTarball {
    url = "https://github.com/danwdart/home-manager/archive/release-21.11.tar.gz";
  };
in {
  imports =
    [
      "${home-manager}/nixos"
      ./cachix.nix
    ];

  boot = import ./boot.nix pkgs;
  console = import ./console.nix {};
  environment = import ./environment.nix {pkgs = pkgs; unstable = unstable; config = config; lib = lib;};
  hardware = import ./hardware.nix pkgs;
  i18n = import ./i18n.nix {};
  networking = import ./networking.nix { lib = lib; };
  nix = import ./nix.nix {};
  nixpkgs = import ./nixpkgs.nix {};
  programs = import ./programs.nix {};
  security = import ./security.nix pkgs;
  services = import ./services.nix pkgs;
  sound = import ./sound.nix {};
  system = import ./system.nix {};
  systemd = import ./systemd.nix {};
  time = import ./time.nix {};
  users = import ./users.nix {};
  virtualisation = import ./virtualisation.nix {};
  
  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # todo move

  powerManagement.powertop.enable = true;
}

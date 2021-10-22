# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  nixpkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  };
  unstable = import <unstable> {
    config = {
      allowUnfree = true;
    };
  };
  master = import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {
    config = {
      allowUnfree = true;
    };
  };
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
  };
in {
  imports =
    [
      "${home-manager}/nixos"
      ./cachix.nix
    ];

  boot = import ./boot.nix {pkgs = pkgs; unstable = unstable; master = master;};
  console = import ./console.nix {};
  environment = import ./environment.nix {pkgs = pkgs; unstable = unstable; master = master; config = config; lib = lib;};
  hardware = import ./hardware.nix {pkgs = pkgs; unstable = unstable;};
  i18n = import ./i18n.nix {};
  networking = import ./networking.nix {};
  nix = import ./nix.nix {};
  nixpkgs = import ./nixpkgs.nix {};
  programs = import ./programs.nix {};
  security = import ./security.nix {};
  services = import ./services.nix {pkgs = pkgs;};
  sound = import ./sound.nix {};
  system = import ./system.nix {};
  systemd = import ./systemd.nix {};
  time = import ./time.nix {};
  users = import ./users.nix {};
  virtualisation = import ./virtualisation.nix {};
  
  home-manager.users.dwd = import ./users/dwd/home.nix {pkgs = pkgs; unstable = unstable;};

  # todo move

  powerManagement.powertop.enable = true;
}

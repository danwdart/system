# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  nixpkgs = import <nixpkgs> {};
  unstable = import <unstable> {};
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
  };
in {
  imports =
    [
      "${home-manager}/nixos"
      ./cachix.nix
    ];

  boot = import ./boot.nix {};
  console = import ./console.nix {};
  environment = import ./environment.nix {pkgs = pkgs; config = config; lib = lib;};
  hardware = import ./hardware.nix {pkgs = pkgs; unstable = unstable;};
  i18n = import ./i18n.nix {};
  networking = import ./networking.nix {};
  nix = import ./nix.nix {};
  nixpkgs = import ./nixpkgs.nix {};
  programs = import ./programs.nix {};
  security = import ./security.nix {};
  services = import ./services.nix {pkgs = pkgs;};
  sound = import ./sound.nix {};
  systemd = import ./systemd.nix {};
  time = import ./time.nix {};
  users = import ./users.nix {};
  virtualisation = import ./virtualisation.nix {};
  
  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

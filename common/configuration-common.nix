# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib,  ... }:
let
  hostName = "alderamin";
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
  environment = import ./environment.nix {pkgs = pkgs;  config = config; lib = lib;};
  hardware = import ./hardware.nix pkgs;
  i18n = import ./i18n.nix {};
  networking = import ./networking.nix { lib = lib; hostName = hostName; };
  nix = import ./nix.nix { pkgs = pkgs; };
  nixpkgs = import ./nixpkgs.nix {};
  programs = import ./programs.nix { pkgs = pkgs; };
  security = import ./security.nix pkgs;
  services = import ./services.nix { pkgs = pkgs; hostName = hostName; hostDir = hostDir; privateDir = privateDir; };
  sound = import ./sound.nix {};
  system = import ./system.nix { hostName = hostName; };
  systemd = import ./systemd.nix {};
  time = import ./time.nix {};
  users = import ./users.nix { privateDir = privateDir; };
  virtualisation = import ./virtualisation.nix {};

  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # todo move

  powerManagement.powertop.enable = true;

  specialisation.server-mode.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.enable = lib.mkForce false;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
  };

  /*
  specialisation.cinnamon.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    services.xserver.desktopManager.cinnamon.enable = true;
    services.cinnamon.apps.enable = true;
  };

  specialisation.gnome.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
  };

  specialisation.surf.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    services.xserver.desktopManager.surf-display.enable = true;
    services.xserver.desktopManager.surf-display.defaultWwwUri = "https://jolharg.com";
  };

  specialisation.retroarch.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    services.xserver.desktopManager.retroarch.enable = true;
  };

  specialisation.pantheon.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    services.xserver.desktopManager.pantheon.enable = true;
  };

  specialisation.enlightenment.configuration = {
    environment.systemPackages = import ./packages/console/packages.nix pkgs;
    services.xserver.displayManager.sddm.enable = lib.mkForce false;
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.plasma5.enable = lib.mkForce false;
    services.xserver.desktopManager.enlightenment.enable = true;
  };
  */
}

# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, hostName, ... }:
let
  rootDir = "/home/dwd/code/mine/nix/system";
  hostDir = "${rootDir}/${hostName}";
  privateDir = "${hostDir}/private";
in
{
  imports =
    [
      ./configuration-common.nix
    ];

  environment = import ./environment.nix {pkgs = pkgs;  config = config; lib = lib; systemPackages = import ./packages/packages.nix pkgs;};
  hardware = import ./hardware.nix {pkgs = pkgs; isDesktop = true;};
  programs = import ./programs.nix { pkgs = pkgs; isDesktop = true; };
  services = import ./services.nix { pkgs = pkgs; hostName = hostName; hostDir = hostDir; privateDir = privateDir; isDesktop = true; };

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

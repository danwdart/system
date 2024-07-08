# man 5 configuration.nix
# nixos-help
{ config, pkgs, lib, hostName, internalIPv4, externalIPv4, localIPv6, globalIPv6, fqdn, ... }:
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

  environment = import ./environment.nix {pkgs = pkgs;  config = config; lib = lib; systemPackages = import ./packages/console/packages.nix pkgs; };
  hardware = import ./hardware.nix { pkgs = pkgs; isDesktop = false; };
  networking = import ./networking.nix { lib = lib; hostName = hostName; isDesktop = false; };
  programs = import ./programs.nix { pkgs = pkgs; isDesktop = false; };
  security = import ./security.nix { pkgs = pkgs; isDesktop = false; hostName = hostName; };
  services = import ./services.nix { pkgs = pkgs; hostName = hostName; hostDir = hostDir; privateDir = privateDir; internalIPv4 = internalIPv4; externalIPv4 = externalIPv4; localIPv6 = localIPv6; globalIPv6 = globalIPv6; fqdn = fqdn; isDesktop = false; };
  systemd = import ./systemd.nix { privateDir = privateDir; isDesktop = false; };
  
  home-manager.users.dwd = import ./users/dwd/home.nix { pkgs = pkgs; isDesktop = false; };
}

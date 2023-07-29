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

  environment = import ./environment.nix {pkgs = pkgs;  config = config; lib = lib; systemPackages = import ./packages/console/packages.nix pkgs;};
  hardware = import ./hardware.nix {pkgs = pkgs; isDesktop = false;};
  programs = import ./programs.nix { pkgs = pkgs; isDesktop = false; };
  services = import ./services.nix { pkgs = pkgs; hostName = hostName; hostDir = hostDir; privateDir = privateDir; isDesktop = false; };
}

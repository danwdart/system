{ pkgs, ... }:
{
  systemPackages = import ./packages.nix pkgs;

  pathsToLink = [
    "/share/nix-direnv"
    "/share/applications"
  ];
}
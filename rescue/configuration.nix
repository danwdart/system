{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration-common.nix
    ];

  networking.hostName = "rescue";
}

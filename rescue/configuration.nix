{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./configuration-common.nix
    ];
}

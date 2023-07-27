# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

let
  hostName = "zhang";
in {
  imports =
    [
      ./hardware-configuration.nix
      ../common/configuration-common.nix
    ];

  networking.hostName = hostName;

  services.openssh.banner = "Connection established to ${hostName}. Unauthorised connections are logged.\n";

  environment.systemPackages = import ../common/packages/console/packages.nix pkgs;
  services.xserver.enable = lib.mkForce false;
  services.xserver.displayManager.sddm.enable = lib.mkForce false;
  services.xserver.desktopManager.plasma5.enable = lib.mkForce false;

  specialisation = {};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

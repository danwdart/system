# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let impermanence = builtins.fetchTarball {
      url =
        "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    };
in {
  imports =
    [
      "${impermanence}/nixos.nix"
      ./hardware-configuration.nix
      ./configuration-common.nix
    ];

  networking.hostName = "fafnir";
}

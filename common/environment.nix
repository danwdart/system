{ pkgs, unstable, lib, config, ... }:
{
  systemPackages = import ./packages.nix {pkgs = pkgs; unstable = unstable;};

  pathsToLink = [
    "/share/nix-direnv"
    "/share/applications"
  ];

  # Workaround for NixOS issue https://github.com/NixOS/nixpkgs/issues/110468
  sessionVariables.LD_LIBRARY_PATH = lib.mkForce "${config.services.pipewire.package.jack}/lib";
}
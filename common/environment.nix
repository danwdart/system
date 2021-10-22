{ pkgs, unstable, master, lib, config, ... }:
{
  systemPackages = import ./packages/packages.nix {pkgs = pkgs; unstable = unstable; master = master;};

  pathsToLink = [
    "/share/nix-direnv"
    "/share/applications"
  ];

  # Workaround for NixOS issue https://github.com/NixOS/nixpkgs/issues/110468
  sessionVariables.LD_LIBRARY_PATH = lib.mkForce "${config.services.pipewire.package.jack}/lib";
}
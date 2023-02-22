{ pkgs, config, ... }:

{
  environment.packages = with pkgs; [
    bc
    bzip2
    cachix
    diffutils
    direnv
    findutils
    gawk
    git
    gnugrep
    gnupg
    gnused
    gnutar
    gzip
    hostname
    man
    nginx
    openssh
    systemd
    tzdata
    units
    unzip
    utillinux
    vim
    which
    xz
    zip
  ];
  
  environment.etcBackupExtension = ".bak";
  system.stateVersion = "22.05";

  # After installing home-manager channel like
  #   nix-channel --add https://github.com/rycee/home-manager/archive/release-22.05.tar.gz home-manager
  #   nix-channel --update
  # you can configure home-manager in here like
  #home-manager.config =
  #  { pkgs, lib, ... }:
  #  {
  #    # Read the changelog before changing this value
  #    home.stateVersion = "22.05";
  #
  #    # Use the same overlays as the system packages
  #    nixpkgs = { inherit (config.nixpkgs) overlays; };
  #
  #    # insert home-manager config
  #  };
  # If you want the same pkgs instance to be used for nix-on-droid and home-manager
  #home-manager.useGlobalPkgs = true;
}

# vim: ft=nix

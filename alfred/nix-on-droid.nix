{ pkgs, config, ... }:
let consolePackages = import ../common/packages/console/packages.nix { pkgs = pkgs; unstable = pkgs; };
  sshdTmpDirectory = "${config.user.home}/sshd-tmp";
  sshdDirectory = "${config.user.home}/sshd";
  pathToPubKey = "${config.user.home}/.ssh/id_rsa.pub";
  port = 8022;
in {
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
    (pkgs.writeScriptBin "sshd-start" ''
      #!${pkgs.runtimeShell}

      echo "Starting sshd in non-daemonized way on port ${toString port}"
      ${pkgs.openssh}/bin/sshd -f "${sshdDirectory}/sshd_config" -D
    '')
  ];
  
  build.activation.sshd = ''
    $DRY_RUN_CMD mkdir $VERBOSE_ARG --parents "${config.user.home}/.ssh"
    $DRY_RUN_CMD cat ${pathToPubKey} > "${config.user.home}/.ssh/authorized_keys"

    if [[ ! -d "${sshdDirectory}" ]]; then
      $DRY_RUN_CMD rm $VERBOSE_ARG --recursive --force "${sshdTmpDirectory}"
      $DRY_RUN_CMD mkdir $VERBOSE_ARG --parents "${sshdTmpDirectory}"

      $VERBOSE_ECHO "Generating host keys..."
      $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t rsa -b 4096 -f "${sshdTmpDirectory}/ssh_host_rsa_key" -N ""

      $VERBOSE_ECHO "Writing sshd_config..."
      $DRY_RUN_CMD echo -e "HostKey ${sshdDirectory}/ssh_host_rsa_key\nPort ${toString port}\n" > "${sshdTmpDirectory}/sshd_config"

      $DRY_RUN_CMD mv $VERBOSE_ARG "${sshdTmpDirectory}" "${sshdDirectory}"
    fi
  '';
  
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

{ config, pkgs, ... }:
let nixpkgs = import <nixpkgs> {
    config = {
      allowUnfree = true;
    };
  };
  hostName = "almach";
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # systemPackages = import ./packages/packages.nix {pkgs = pkgs; unstable = unstable; };

  environment.systemPackages = with nixpkgs; [
    clamav
    rclone
    # docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    vim
    mtools
    ddate
    pfsshell
    hamlib
    multimon-ng
    units
    ncspot
    get_iplayer
    youtube-dl
    yt-dlp
    autossh
    bind
    doctl
    irssi
    mailutils
    openvpn
    ngrok
    cachix
    direnv
    nix-direnv
    nixpkgs-fmt
    atinout
    lrzsz
    minicom
    mnemonicode
    binwalk
    hexedit
    john
    lynis
    masscan
    nmap
    openssl
    sshuttle
    tcpdump
    aha
    bluez-tools
    cdrtools
    cmatrix
    file
    glances
    hidapi
    htop
    inetutils
    jmtpfs
    jnettop
    lsof
    mono
    ntfs3g
    p7zip
    pciutils
    rpiboot
    socat
    testdisk
    unrar
    unzip
    wget
    audacity
    cool-retro-term
    # vscode
    dosbox
    virt-viewer
    gramps
    geogebra
    gimp
    inkscape
    mplayer
    dbeaver
    postman
    putty
    rdesktop
    scrcpy
    newman
    # slack
    # zoom-us
    xearth
    teams
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "/Volumes/Code/system/almach/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  networking.hostName = hostName;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

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

  # systemPackages = import ./packages/packages.nix {pkgs = pkgs; };

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
    # get_iplayer
    # youtube-dl
    # yt-dlp
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
    nix-index
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
    logisim-evolution
    lsof
    mono
    ntfs3g
    # openjdk17
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
    fontforge
    # vscode
    # dosbox # libGL -> mesa broken
    # virt-viewer # fails to find epoxy/egl.h
    gramps
    # geogebra
    # gimp # wrong architecture
    inkscape
    # mplayer # same gl issue
    # dbeaver # too old!
    postman
    putty
    rdesktop
    scrcpy
    newman
    # slack
    # zoom-us
    xearth
    # teams # nah never using it
  ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "/Volumes/Code/system/almach/darwin-configuration.nix";

  # Doesn't install Homebrew. Firstly needs installation:
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  homebrew = {
    enable = true;
    brews = [
      "docker"
      "docker-compose"
      "tiger-vnc"
      "wireshark"
    ];
    casks = [
      # "chirp" # skip as installed already
      # "dbeaver-community" # skip as installed already
      # "firefox" # skip as installed already
      # "gimp" # skip as installed already
      # "google-chrome" # skip as installed already
      # "libreoffice" # 404
      # "libreoffice-language-pack" # un-upgradeable
      #"microsoft-office"
      # "openmtp" # skip as installed already
      # "slack" # skip as installed already
      # "spotify" # skip as installed already
      "supertuxkart"
      # "transmission" # skip as installed already
      # "tunnelblick" # skip as installed already
      # "visual-studio-code" # skip as installed already
      # "zoom" # 403
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # programs.fish.enable = true;

  networking.hostName = hostName;

  nix.settings.trusted-users = [ "dwd" ];
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

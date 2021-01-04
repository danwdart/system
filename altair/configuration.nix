# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  nix.trustedUsers = [ "root" "dwd" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "altair"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
  virtualisation.anbox.enable = true;
#   virtualisation.lxc.enable = true;
#   virtualisation.lxd.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # networking.interfaces.enp0s3.useDHCP = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "gb";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.layout = "gb";

  services.grocy.enable = true;
  services.grocy.hostName = "altair";
  services.grocy.nginx.enableSSL = false;
  services.grocy.settings.calendar.firstDayOfWeek = 1;
  services.grocy.settings.currency = "GBP";
  services.grocy.settings.culture = "en_GB";

  # security.acme.email = "acme@dandart.co.uk";
  # security.acme.acceptTerms = true;

  # services.miredo.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  programs.adb.enable = true;
  programs.wireshark.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # services.xserver.xkbOptions = "eurosign:e";
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # services.xserver.libinput.enable = true;

  users.users.dwd = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "kvm" "adbusers" "wireshark"]; # Enable ‘sudo’ for the user.
  };

  # $ nix search
  environment.systemPackages = with pkgs; [
    a2jmidid
    ark
    chirp 
    discord
    element-desktop
    firefox
    fldigi
    git
    jack_rack
    kdeApplications.kalarm
    libsForQt5.phonon
    libsForQt5.phonon-backend-gstreamer
    networkmanager
    nixpkgs-fmt
    nmap
    OVMF
    plasma5.plasma-browser-integration
    qemu
    qjackctl
    slack
    spotify
    steam
    thunderbird
    vim
    virglrenderer
    virt-manager
    virt-viewer
    vscode
    wget
    win-qemu
    wsjtx
    xcodebuild
    xorg.xf86videointel
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 8080 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

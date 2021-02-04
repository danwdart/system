# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <unstable> {};
in {
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  nix.trustedUsers = [ "root" "dwd" ];

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "vm.swappiness" = 0;
  };

  xdg.menus.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_5_10;

  networking.hostName = "altair"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.qemuOvmf = true;
  virtualisation.libvirtd.onShutdown = "suspend";
  # virtualisation.anbox.enable = true;

  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.lxc.enable = true;
  # virtualisation.lxd.enable = true;

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

  boot.plymouth.enable = true;

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.xserver.layout = "gb";

  services.grocy.enable = true;
  services.grocy.hostName = "altair";
  services.grocy.nginx.enableSSL = false;
  services.grocy.settings.calendar.firstDayOfWeek = 1;
  services.grocy.settings.currency = "GBP";
  services.grocy.settings.culture = "en_GB";

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_10;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE msf WITH LOGIN PASSWORD 'msf' CREATEDB;
      CREATE DATABASE msf;
      GRANT ALL PRIVILEGES ON DATABASE msf TO msf;
    '';
  };

  # security.acme.email = "acme@dandart.co.uk";
  # security.acme.acceptTerms = true;

  services.udisks2.enable = true;
  
  security.pam.usb.enable = true;

  # services.miredo.enable = true;

  services.pipewire.enable = true;

  nixpkgs.config.allowUnfree = true;
  programs.steam.enable = true;

  programs.adb.enable = true;
  programs.wireshark.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.tcp.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva unstable.pkgsi686Linux.amdvlk ];
  hardware.opengl.extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
  hardware.pulseaudio.support32Bit = true;
  hardware.pulseaudio.zeroconf.discovery.enable = true;
  hardware.pulseaudio.zeroconf.publish.enable = true;
  hardware.pulseaudio.tcp.anonymousClients.allowedIpRanges = [
    "127.0.0.1"
    "192.168.1.0/24"
  ];

  # services.xserver.xkbOptions = "eurosign:e";
  services.printing.enable = true;

  services.samba.enable = true;
  services.samba.nsswins = true;
  services.samba.enableNmbd = true;
  services.samba.enableWinbindd = true;

  #services.samba.shares = {
  #  public = {
  #    path = "/srv/public";
  #    "read only" = true;
  #    browseable = "yes";
  #    "guest ok" = "yes";
  #    comment = "Public samba share.";
  #  };
  #};

  # services.xserver.libinput.enable = true;

  users.users.dwd = {
    createHome = true;
    description = "Dan Dart";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "kvm"
      "adbusers"
      "wireshark"
      "vboxusers"
      "libvirtd"
    ];
  };

  # $ nix search
  # TODO categories path?
  environment.systemPackages = import ./packages.nix pkgs;

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";

  services.avahi.enable = true;
  services.avahi.wideArea = true;
  services.avahi.ipv6 = true;
  services.avahi.nssmdns = true;
  # services.avahi.domainName = "jolharg.com"
  services.avahi.publish.enable = true;
  # services.avahi.browseDomains = [ "jolharg.com" ];
  services.avahi.publish.hinfo = true;
  services.avahi.publish.domain = true;
  # services.avahi.publish.addresses = true;
  services.avahi.publish.userServices = true;
  services.avahi.publish.workstation = true;

  services.fail2ban.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 80 139 445 3389 4713 5900 8080 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];
  networking.firewall.pingLimit = "--limit 1/minute --limit-burst 5";
  networking.firewall.checkReversePath = true;
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

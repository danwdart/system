# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import <unstable> {};
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
  };
in {
  imports =
    [
      "${home-manager}/nixos"
    ];

  nix.binaryCaches = [
    "https://cache.nixos.org"
    "https://nixcache.reflex-frp.org"
    "https://nixcache.webghc.org"
  ];

  nix.binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    "hydra.webghc.org-1:knW30Yb8EXYxmUZKEl0Vc6t2BDjAUQ5kfC1BKJ9qEG8="
  ];

  nix.trustedUsers = [ "root" "dwd" ];

  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 8d";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
  
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    # all magic sysrq keys
    "kernel.sysrq" = 1;
    # try not to use swap
    "vm.swappiness" = 0;
  };

  boot.kernelPackages = unstable.linuxPackages_latest;

  networking = {
    hostName = "fafnir"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    nameservers = [
      "94.140.14.14" "94.140.15.15" "2a10:50c0::ad1:ff" "2a10:50c0::ad2:ff"
    ];
    networkmanager = {
      enable = true;
    };
  };

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.qemuOvmf = true;
  virtualisation.libvirtd.onShutdown = "suspend";

  virtualisation.virtualbox.host.enable = true;

  # causes constant rebuilds
  # virtualisation.virtualbox.host.enableExtensionPack = true;

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  # networking.interfaces.enp0s3.useDHCP = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "gb";
  };

  boot.plymouth.enable = true;

  services.cron = {
    enable = true;
    # mailto = "cron@dandart.co.uk";
    systemCronJobs = [
      # see https://www.freebsd.org/cgi/man.cgi?crontab%285%29 for special:
      #@weekly @monthly @yearly @annually @hourly @daily @reboot 
      #m     h d m w
      # Every half hour on the quarter hour
      "15,45 *                  * * *         dwd     . /etc/profile; ERR=$(nix-channel --update 2>&1) || echo $ERR"
      "15,45 *                  * * *         root    . /etc/profile; ERR=$(nix-channel --update 2>&1) || echo $ERR"
      # Every two hours at weekends
      "0     */2                * * 0,6       root    . /etc/profile; nix-channel --update; nixos-rebuild switch"
      # Every two hours at non-working hours on weekdays
      "0     0,2,4,6,8,18,20,22 * * 1,2,3,4,5 root    . /etc/profile; nix-channel --update; nixos-rebuild switch"
      # Every six hours at weekends
      "0     */6                * * 0,6       root    . /etc/profile; nix-store --optimise"
      # Every six hours except midday on weekdays
      "0     0,6,18             * * 1,2,3,4,5 root    . /etc/profile; nix-store --optimise"
      # Every Sunday at midnight
      "0     0                  * * 0         root    . /etc/profile; nix-collect-garbage -d && nix-store --gc && nix-store --delete"
    ];
  };

  services.xserver.enable = true;
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      autoLogin = {
        relogin = true;
      };
    };
    autoLogin = {
      enable = true;
      user = "dwd";
    };
  };
  
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "terminate:ctrl_alt_bksp,caps:escape,compose:ralt";
  services.xserver.xkbModel = "latitude";
  console.useXkbConfig = true;

  services.udisks2.enable = true;
  
  services.pipewire.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.wireshark.enable = true;

  programs.fuse.userAllowOther = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.xserver.libinput.enable = true;

  # Don't allow mutation of users outside of the config.
  users.mutableUsers = false;

  # Set a root password, consider using
  # initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.users.root.initialHashedPassword = "$6$8RZ1PPxKU6h$dNHnIWiq.h8s.7SpMW14FzK9bJwg1f6Mt.972/2Fij4zPrhR0X4m3JTNPtGAyeMKZk3I8x/Xro.vJolwVvwd9.";

  users.users.dwd = {
    createHome = true;
    description = "Dan Dart";
    initialHashedPassword = "$6$EDn9CboEV/$ESAQifZD0wiVkYf1MuyLqs.hP7mvelpoPnSGEI7CmwuUifi090PT6FQqHsdhlZSXSlqrT9EH.mIfUvxPCA5q.1";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
      "kvm"
      "wireshark"
      "vboxusers"
      "libvirtd"
    ];
  };

  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # $ nix search
  environment.systemPackages = import ./packages.nix pkgs;

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
  environment.pathsToLink = [
    "/share/nix-direnv"
    "/share/applications"
  ];  

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    banner = "Connection established to rescue. Unauthorised connections are logged.\n";
  };

  services.fail2ban.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.pingLimit = "--limit 1/minute --limit-burst 5";
  networking.firewall.checkReversePath = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

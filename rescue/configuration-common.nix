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
      ./cachix.nix
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

  #boot.binfmt.emulatedSystems = [
    # "wasm32-wasi"
  #  "wasm64-wasi"
  #  "x86_64-windows"
    # "i686-windows"
    # "i686-linux"
    # "mips64-linux"
    # "mips64el-linux"
    # "sparc64-linux"
    # "aarch64_be-linux"
  #  "aarch64-linux"
  #  "powerpc64-linux"
  #  "riscv64-linux"
  #];

  systemd.tmpfiles.rules = [
  # only on big evil desktop
  #  "w /sys/devices/system/cpu/cpufreq/boost - - - - 0"
  ];


  boot.kernelPackages = unstable.linuxPackages_latest;

  networking = {
    hostName = "fafnir"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    nameservers = [
      # if using DoH/DoT proxy
      # "127.0.0.1" "::1"
      # opennic, giving http://grep.geek etc
      # "194.36.144.87" "94.247.43.254" "2a03:4000:4d:c92:88c0:96ff:fec6:b9d" "2a00:f826:8:1::254"
      # also opennic
      # "95.217.229.211" "165.22.224.164" "2a01:4f9:4b:39ea::301" "2604:a880:cad:d0::d9a:f001"
      # adguard
      "94.140.14.14" "94.140.15.15" "2a10:50c0::ad1:ff" "2a10:50c0::ad2:ff"
      # quad9
      # "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9"
    ];
    # resolvconf.enable = false;
    networkmanager = {
      enable = true;
  #    dns = "
      #insertNameservers = [
      # extra stuff only
      #];
    };
  };

  #services.dnscrypt-proxy2 = {
  #  enable = true;
  #  settings = {
  #    ipv6_servers = true;
  #    require_dnssec = true;
  #    sources.public-resolvers = {
  #      urls = [
  #        "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
  #        "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
  #      ];
  #      cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
  #      minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
  #    };
  #    # You can choose a specific set of servers from https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
  #    server_names = [
  #      # doh: https://dns.adguard.com/dns-query dot: dns.adguard.com
  #      # adguard-dns-doh
  #      "sdns://AgMAAAAAAAAADzE3Ni4xMDMuMTMwLjEzMCCsFdIhxY-VWoedpSrEKWAhaBEVj-8L-p_FJl6wMpPufg9kbnMuYWRndWFyZC5jb20KL2Rucy1xdWVyeQ"
  #      # ahadns-doh-nl
  #      "sdns://AgMAAAAAAAAACTUuMi43NS43NaAyhv9lpl-vMghe6hOIw3OLp-N4c8kGzOPEootMwqWJiKBETr1nu4P4gHs5Iek4rJF4uIK9UKrbESMfBEz18I33ziDMEGDTnIMptitvvH0NbfkwmGm5gefmOS1c2PpAj02A5hFkb2gubmwuYWhhZG5zLm5ldAovZG5zLXF1ZXJ5"
  #    ];
  #  };
  #};

  #systemd.services.dnscrypt-proxy2.serviceConfig = {
  #  StateDirectory = "dnscrypt-proxy2";
  #};

  time.timeZone = "Europe/London";

  virtualisation.docker.enable = true;
  virtualisation.docker.autoPrune.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.qemuOvmf = true;
  virtualisation.libvirtd.onShutdown = "suspend";
  # virtualisation.anbox.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
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
      "0     */2                * * 0,6       root    . /etc/profile; nix-channel --update; nixos-rebuild switch -I nixos-config=/home/dwd/code/mine/nix/system/fafnir/configuration.nix"
      # Every two hours at non-working hours on weekdays
      "0     0,2,4,6,8,18,20,22 * * 1,2,3,4,5 root    . /etc/profile; nix-channel --update; nixos-rebuild switch -I nixos-config=/home/dwd/code/mine/nix/system/fafnir/configuration.nix"
      # Every six hours at weekends
      "0     */6                * * 0,6       root    . /etc/profile; nix-store --optimise"
      # Every six hours except midday on weekdays
      "0     0,6,18             * * 1,2,3,4,5 root    . /etc/profile; nix-store --optimise"
      # Every Sunday at midnight
      "0     0                  * * 0         root    . /etc/profile; nix-collect-garbage -d && nix-store --gc && nix-store --delete"
    ];
  };

  #services.logcheck = {
  #  enable = true;
  #  level = "paranoid";
  #  mailTo = "logcheck@dandart.co.uk";
  #};

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
  # services.xserver.videoDrivers = [ "amdgpu" ];

  #services.xserver.windowManager.xmonad = {
  #  enable = true;
  #  enableContribAndExtras = true;
  #  config = pkgs.writeText "xmonad.hs" ''
  #    import XMonad
  #    main = xmonad defaultConfig
  #        { terminal    = "urxvt"
  #        , modMask     = mod4Mask
  #        , borderWidth = 3
  #        }
  #  '';
  #  extraPackages = haskellPackages: [
  #    haskellPackages.xmonad-contrib
  #    haskellPackages.monad-logger
  #  ];
  #  haskellPackages = unstable.haskell.packages.ghc901;
  #};
  
  services.xserver.layout = "gb";
  services.xserver.xkbOptions = "terminate:ctrl_alt_bksp,caps:escape,compose:ralt";
  services.xserver.xkbModel = "latitude";
  console.useXkbConfig = true;

  services.udisks2.enable = true;
  
  # security.pam.usb.enable = true;
  # TODO pam phone fingerprint?

  # services.miredo.enable = true;

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

  networking.hostName = "rescue";
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

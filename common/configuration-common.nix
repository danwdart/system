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
      "15,45 *                  * * *         dwd     . /etc/profile; ERR=$(nice -n19 nix-channel --update 2>&1) || echo $ERR"
      "15,45 *                  * * *         root    . /etc/profile; ERR=$(nice -n19 nix-channel --update 2>&1) || echo $ERR"
      # Every two hours at weekends
      # needs sudo for some env??
      "0     */2                * * 0,6       root    . /etc/profile; nice -n19 nix-channel --update; nice -n19 sudo nixos-rebuild switch --fast -I nixos-config=/home/dwd/code/mine/nix/system/fafnir/configuration.nix"
      # Every two hours at non-working hours on weekdays
      "0     0,2,4,6,8,18,20,22 * * 1,2,3,4,5 root    . /etc/profile; nice -n19 nix-channel --update; nice -n19 sudo nixos-rebuild switch --fast -I nixos-config=/home/dwd/code/mine/nix/system/fafnir/configuration.nix"
      # Every six hours at weekends
      "0     */6                * * 0,6       root    . /etc/profile; nice -n19 nix-store --optimise"
      # Every six hours except midday on weekdays
      "0     0,6,18             * * 1,2,3,4,5 root    . /etc/profile; nice -n19 nix-store --optimise"
      # Every Sunday at midnight
      "0     0                  * * 0         root    . /etc/profile; nice -n19 nix-collect-garbage -d && nice -n19 nix-store --gc && nice -n19 nix-store --delete"
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

  services.grocy.enable = true;
  services.grocy.hostName = "fafnir.dandart.co.uk";
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

  security.acme.email = "acme@dandart.co.uk";
  security.acme.acceptTerms = true;

  services.udisks2.enable = true;
  
  # security.pam.usb.enable = true;
  # TODO pam phone fingerprint?

  # services.miredo.enable = true;

  services.pipewire.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  programs.adb.enable = true;
  programs.wireshark.enable = true;

  programs.fuse.userAllowOther = true;

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
  hardware.pulseaudio.extraModules = with pkgs; [ pulseaudio-modules-bt ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.postfix = {
    enable = true;
    domain = "jolharg.com";
    rootAlias = "dwd";
    # [smtp.gmail.com]:587    username@gmail.com:password -> sasl_passwd
    config = {
      smtp_sasl_auth_enable = true;
      smtp_sasl_security_options = "noanonymous";
      smtp_use_tls = true;
      # postmap this!
      smtp_sasl_password_maps = "hash:/home/dwd/code/mine/nix/system/fafnir/private/sasl_passwd";
    };
    relayHost = "smtp.gmail.com";
    relayPort = 587;
    relayDomains = [
      "dandart.co.uk"
      "fafnir.jolharg.com"
      "jolharg.com"
    ];
    setSendmail = true;
    virtual = ''
      @fafnir dan@dandart.co.uk
      @fafnir.jolharg.com dan@dandart.co.uk
    '';
  };

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
      "adbusers"
      "wireshark"
      "vboxusers"
      "libvirtd"
    ];
  };

  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;

  # $ nix search
  environment.systemPackages = import ./packages.nix pkgs;

  # TODO Extra desktop files
  # bristol
  # polyphone
  # tuxguitar
  # /share/games/armagetronad/desktop/armagetronad.desktop
  # ioquake3
  # /share/applications/mupen64plus.desktop
  # nethack-qt
  # nexuiz
  # openarena
  # quake3e
  # quakespasm
  # sauerbraten
  # speed_dreams
  # torcs
  # trigger
  # urbanterror
  # vkquake
  # yquake2
  # soundmodem
  # sleepyhead
  # putty

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
    banner = "Connection established to altair. Unauthorised connections are logged.\n";
  };

  #services.xrdp.enable = true;
  #services.xrdp.defaultWindowManager = "startplasma-x11";

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

  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  # networking.firewall.allowedUDPPorts = [];
  # networking.firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  # networking.firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];

  networking.firewall.pingLimit = "--limit 1/minute --limit-burst 5";
  networking.firewall.checkReversePath = true;

  # KDE Connect, PulseAudio and Samba - only from LANs
  networking.firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --source 192.168.0.0/16 --dport 1714:1764 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --source 192.168.0.0/16 -m multiport --dports 139,445 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --source 192.168.0.0/16 --dport 4713 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.0.0/16 --dport 1714:1764 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.0.0/16 -m multiport --dports 137,138 -j nixos-fw-accept
  '';

  networking.extraHosts = ''
    192.168.15.18  api.timetrack.local
    192.168.15.18  mail.timetrack.local
  '';

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

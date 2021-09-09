{ pkgs, ... }:
{
  cron = {
    # enable = true;
    # Will only show in outbox if enabled
    # mailto = "cron@dandart.co.uk";
    systemCronJobs = [
      # see https://www.freebsd.org/cgi/man.cgi?crontab%285%29 for special:
      #@weekly @monthly @yearly @annually @hourly @daily @reboot 
      #m     h d m w
      # Every Sunday at midnight
    ];
  };

  freenet = {
    # enable = true;
  };

  i2p = {
    # enable = true;
    /*
    proto = {
      i2pControl = {
        enable = true;
      };
      i2cp = {
        enable = true;
      };
      sam = {
        enable = true;
      };
      bob = {
        enable = true;
      };
      http = {
        enable = true;
      };
      i2pd = {
        enable = true;
        websocket = {
          enable = true;
        };
      };
    };
    ntcp2 = {
      enable = true;
    };
    upnp = {
      enable = true;
    };
    */
  };

  tor = {
    # enable = true;
    client = {
      # enable = true;
    };
  };

  zeronet = {
    # enable = true;
    # torAlways = true;
  };

  #logcheck = {
  #  enable = true;
  #  level = "paranoid";
  #  mailTo = "logcheck@dandart.co.uk";
  #};

  xserver.enable = true;
  xserver.displayManager = {
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
  
  xserver.desktopManager.plasma5.enable = true;
  # xserver.videoDrivers = [ "amdgpu" ];

  #xserver.windowManager.xmonad = {
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
  
  xserver.layout = "gb";
  xserver.xkbOptions = "terminate:ctrl_alt_bksp,caps:escape,compose:ralt";
  xserver.xkbModel = "latitude";
  
  grocy.enable = true;
  grocy.hostName = "fafnir.dandart.co.uk";
  grocy.nginx.enableSSL = false;
  grocy.settings.calendar.firstDayOfWeek = 1;
  grocy.settings.currency = "GBP";
  grocy.settings.culture = "en_GB";

  postgresql = {
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

  udisks2.enable = true;

  usbguard = {
    enable = true;
    rules = builtins.readFile ./conf/usbguard.rules;
  };

  # miredo.enable = true;

  pipewire = {
    enable = true;
    jack = {
      enable = true;
    };
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse = {
      enable = true;
    };
  };

  postfix = {
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

  printing.enable = true;

  samba.enable = true;
  samba.nsswins = true;
  samba.enableNmbd = true;
  samba.enableWinbindd = true;

  xserver.libinput.enable = true;

  openssh = {
    enable = true;
    openFirewall = true;
  };

  #xrdp.enable = true;
  #xrdp.defaultWindowManager = "startplasma-x11";

  avahi.enable = true;
  avahi.wideArea = true;
  avahi.ipv6 = true;
  avahi.nssmdns = true;
  # avahi.domainName = "jolharg.com"
  avahi.publish.enable = true;
  # avahi.browseDomains = [ "jolharg.com" ];
  avahi.publish.hinfo = true;
  avahi.publish.domain = true;
  # avahi.publish.addresses = true;
  avahi.publish.userServices = true;
  avahi.publish.workstation = true;

  fail2ban.enable = true;

  ntopng.enable = true;
}
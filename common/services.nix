pkgs:
let
  # needs /persist, see: https://github.com/nix-community/impermanence/issues/87
  rootDir = "/persist/home/dwd/code/mine/nix/system";
  haskellSites = "/persist/home/dwd/code/mine/haskell";
  roqHome = "/persist/home/dwd/code/commissions/roqqett";
  websites = "${haskellSites}/websites/.sites";
  hostname = "fafnir";
  hostDir = "${rootDir}/${hostname}";
  privateDir = "${hostDir}/private";
in {
  cron = {
    enable = true;
    # Will only show in outbox if enabled
    # mailto = "cron@dandart.co.uk";
    systemCronJobs = [
      # see https://www.freebsd.org/cgi/man.cgi?crontab%285%29 for special:
      #@weekly @monthly @yearly @annually @hourly @daily @reboot 
      #m     h d m w
      "0 * * * * dwd  RESULT=$(nix-channel --update 2>&1); [ 0 != $? ] && echo $RESULT"
      "0 * * * * root RESULT=$(nix-channel --update 2>&1); [ 0 != $? ] && echo $RESULT"
    ];
  };

  earlyoom = {
    enable = true;
    enableNotifications = true;
    freeSwapThreshold = 5;
    freeMemThreshold = 5;
    # useKernelOOMKiller = false;
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
  #  haskellPackages = pkgs.haskell.packages.ghc923;
  #};
  
  xserver.layout = "gb";
  xserver.xkbOptions = "terminate:ctrl_alt_bksp,caps:escape,compose:ralt";
  xserver.xkbModel = "latitude";

  nginx = {
    enable = true;
    # enableReload = true;
    defaultListenAddresses = [
      "127.0.0.1"
      "192.168.1.101"
    ];
    statusPage = true;
    recommendedProxySettings = true;
    # sso = {};
    virtualHosts = {
      "localhost" = {
        serverAliases = [
          "127.0.0.1"
          "192.168.1.101"
        ];
        root = "${hostDir}/private_html";
      };
      "79.78.147.142" = {
        root = "${hostDir}/public_html";
      };
      "44.131.255.4" = {
        root = "${hostDir}/radio_html";
      };
      "home.dandart.co.uk" = {
        default = true;
        forceSSL = true;
        enableACME = true;
        # useACMEHost = ""; # security.acme.certs
        root = "${hostDir}/public_html";
      };
      "nextcloud.dandart.co.uk" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
      };
      "dev.localhost" = {
        # http3 = true;
        forceSSL = true;
        sslCertificate = "${roqHome}/roqqett-web-api/certs/dev-localhost-cert.pem";
        sslCertificateKey = "${roqHome}/roqqett-web-api/certs/dev-localhost-key.pem";
        serverAliases = [];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://localhost:5000/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${roqHome}/Data/static/";
          };
        };
      };
      "roqqett.dandart.co.uk" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [
          "roqqett.dandart.uk"
        ];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://localhost:5000/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${roqHome}/Data/static/";
          };
        };
      };
      "roq-wp.dandart.co.uk" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [
          "roq-wp.dandart.uk"
        ];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://localhost:5600/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${hostDir}/roqqett_html";
          };
        };
      };
      "dev.dandart.co.uk" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/dandart";
            proxyWebsockets = true;
          };
        };
      };
      "dev.jolharg.com" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "/persist/home/dwd/code/mine/haskell/websites/.sites/jolharg";
            proxyWebsockets = true;
          };
        };
      };
      "dev.madhackerreviews.com" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/madhacker";
            proxyWebsockets = true;
          };
        };
      };
      "dev.m0ori.com" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/m0ori";
            proxyWebsockets = true;
          };
        };
      };
      "dev.blog.dandart.co.uk" = {
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/blog";
            proxyWebsockets = true;
          };
        };
      };
      "dev.jobfinder.jolharg.com" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        # htaccess?
        extraConfig = ''
          error_page 404 /index.html;
        '';
        locations = {
          "/" = {
            root = "${haskellSites}/jobfinder/dist-newstyle/build/x86_64-linux/ghcjs-8.6.0.1/ui-0.1.0.0/x/ui/build/ui/ui.jsexe";
            proxyWebsockets = true;
          };
          "/api/" = {
            proxyPass = "http://localhost:8081/api/";
          };
        };
      };
      "jobfinder.jolharg.com" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        # htaccess?
        extraConfig = ''
          error_page 404 /index.html;
        '';
        locations = {
          "/" = {
            root = "${haskellSites}/jobfinder/result/ui/bin/ui.jsexe";
            proxyWebsockets = true;
          };
          "/api/" = {
            proxyPass = "http://localhost:8081/api/";
          };
        };
      };
      "api.jobfinder.jolharg.com" = {
        # http3 = true;
        forceSSL = true;
        enableACME = true;
        serverAliases = [];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://localhost:8081/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${haskellSites}/jobfinder/app/backend/data";
          };
        };
      };
    };
  };
 
  grocy = {
    enable = true;
    hostName = "grocy.dandart.co.uk";
    nginx = {
      enableSSL = true;
    };
    settings = {
      calendar = {
        firstDayOfWeek = 1;
      };
      currency = "GBP";
      culture = "en_GB";
    };
  };

  plex = {
    enable = true;
    package = pkgs.plex;
    openFirewall = true;
  };

  nextcloud = {
    enable = true;
    package = pkgs.nextcloud24;
    https = true;
    hostName = "nextcloud.dandart.co.uk";
    webfinger = true;
    config = {
      dbtype = "pgsql";
      dbhost = "localhost";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbpassFile = "${privateDir}/nextcloud/dbpass";
      adminuser = "root";
      adminpassFile = "${privateDir}/nextcloud/adminpass";
      defaultPhoneRegion = "GB";
      overwriteProtocol = "https";
    };
    autoUpdateApps = {
      enable = true;
    };
  };

  postgresql = let
    nextcloudPassword = builtins.readFile "${privateDir}/nextcloud/dbpass";
    msfPassword = builtins.readFile "${privateDir}/msf/dbpass";
  in {
    enable = true;
    package = pkgs.postgresql_14;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all ::1/128 trust
    '';
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE msf WITH LOGIN PASSWORD '${msfPassword}' CREATEDB;
      CREATE DATABASE msf;
      GRANT ALL PRIVILEGES ON DATABASE msf TO msf;
      CREATE ROLE nextcloud WITH LOGIN PASSWORD '${nextcloudPassword}' CREATEDB;
      CREATE DATABASE nextcloud;
      GRANT ALL PRIVILEGES ON DATABASE nextcloud TO nextcloud;
    '';
  };

  udisks2.enable = true;

  #usbguard = {
  #  enable = true;
  #  rules = builtins.readFile ./conf/usbguard.rules;
  #};

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
      smtp_sasl_password_maps = "hash:${privateDir}/sasl_passwd";
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

  avahi = {
    enable = true;
    wideArea = true;
    ipv6 = true;
    nssmdns = true;
    # domainName = "jolharg.com"
    publish = {
      enable = true;
      # browseDomains = [ "jolharg.com" ];
      hinfo = true;
      domain = true;
      # addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  fail2ban.enable = true;

  # ntopng.enable = true;

  mozillavpn.enable = true;
}

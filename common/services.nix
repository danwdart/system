{ pkgs, hostName, hostDir, privateDir, isDesktop, ... }:
let
  # needs /persist, see: https://github.com/nix-community/impermanence/issues/87
  rootDir = "/home/dwd/code/mine/nix/system";
  haskellSites = "/home/dwd/code/mine/haskell";
  roqHome = "/home/dwd/code/commissions/roqqett";
  websites = "${haskellSites}/websites/.sites";
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

  envfs.enable = true;

  freenet = {
    # enable = true;
  };

  fwupd = {
    enable = true;
  };

  samba-wsdd = {
    enable = true;
  };

  vscode-server.enable = true;

  samba = {
    enable = true;
    nsswins = true;
    enableNmbd = true;
    enableWinbindd = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.1. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/dwd/Public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "dwd";
        "force group" = "users";
      };
       private = {
         path = "/home/dwd";
         browseable = "yes";
         "read only" = "no";
         "guest ok" = "no";
         "create mask" = "0644";
         "directory mask" = "0755";
         "force user" = "dwd";
         "force group" = "users";
       };
    };
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

  # tailscale = {
  #   enable = true;
  # };

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

  xserver = if isDesktop then {
    enable = true;
    displayManager = {
      sddm = {
        enable = true;
        #autoLogin = {
        #  relogin = true;
        #};
      };
      #autoLogin = {
       # enable = true;
       # user = "dwd";
      #};
      #surf-display = {
      #  enable = true;
      #};
      #retroarch = {
      #  enable = true;
      #};
      #kodi = {
      #  enable = true;
      #}
    };
    desktopManager = {
      plasma5 = {
        enable = true;
      };
      #cinnamon = {
      #  enable = true;
      #};
      #enlightenment = {
      #  enable = true;
      #};
    };
    layout = "gb";
    xkbOptions = "terminate:ctrl_alt_bksp,caps:escape,compose:ralt";
    xkbModel = "inspiron";
    libinput = {
      enable = true;
    };
  } else {};

  #cinnamon = {
  #  apps = {
  #    enable = true;
  #  };
  #};

  gvfs = {
    enable = true;
  };

  touchegg = {
    enable = true;
  };

  # BIG BUG HERE: https://github.com/NixOS/nixpkgs/issues/126374
  tt-rss = {
    enable = true;
    enableGZipOutput = true;
    database = {
      # for permissions we'll read and send instead of using passwordFile.
      password = builtins.readFile "${privateDir}/tt-rss/dbpass";
    };
    #auth = {
      # autoCreate = true;
      # autoLogin = true;
    #};
    email = {
      fromName = "tt-rss";
      fromAddress = builtins.readFile "${privateDir}/tt-rss/email_from_address";
      login = builtins.readFile "${privateDir}/tt-rss/email_login";
      password = builtins.readFile "${privateDir}/tt-rss/email_password";
      security = "tls";
      server = builtins.readFile "${privateDir}/tt-rss/email_server";
    };
    #registration = {
    #  enable = true;
    #  maxUsers = 1;
    #};
    selfUrlPath = "https://news.jolharg.com";
    # singleUserMode = true;
    virtualHost = "news.jolharg.com";
  };

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
  #  haskellPackages = pkgs.haskell.packages.ghc92;
  #};

  # Enable touchpad support (enabled default in most desktopManager).
  # xserver.libinput.enable = true;

  # TODO
  #onlyoffice = {
  #  enable = true;
  #  hostname = "office.jolharg.com";
  #  port = 8000;
  #  rabbitmqUrl = "amqp://guest:guest@localhost:5672";
  #  postgresHost = "localhost";
  #  postgresName = "onlyoffice";
  #  postgresUser = "onlyoffice";
  #  postgresPasswordFile = "";
  #  jwtSecretFile = "";
  #};

  nginx = {
    enable = true;
    # enableReload = true;
    defaultListenAddresses = [
      "127.0.0.1"
      # "192.168.1.101"
      "0.0.0.0"
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
        #onlySSL = true;
        #enableACME = true;
        # useACMEHost = ""; # security.acme.certs
        root = "${hostDir}/public_html";
      };
      #"nextcloud.dandart.co.uk" = {
        # http3 = true;
      #  #onlySSL = true;
      #  #enableACME = true;
      #};
      "news.jolharg.com" = {
        # http3 = true;
        #onlySSL = true;
        #enableACME = true;
      };
      #"dev.localhost" = {
      #  # http3 = true;
      #  #onlySSL = true;
      #  sslCertificate = "${roqHome}/roqqett-web-api/certs/dev-localhost-cert.pem";
      #  sslCertificateKey = "${roqHome}/roqqett-web-api/certs/dev-localhost-key.pem";
      #  serverAliases = [];
      #  extraConfig = ''
      #    error_page 502 /502.html;
      #  '';
      #  locations = {
      #    "/" = {
      #      proxyPass = "http://localhost:5000/";
      #      proxyWebsockets = true;
      #    };
      #    "/502.html" = {
      #      root = "${roqHome}/Data/static/";
      #    };
      #  };
      #};
      "roqqett.dandart.co.uk" = {
        # http3 = true;
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [
          "roqqett.dandart.uk"
        ];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://192.168.1.112:5000/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${roqHome}/Data/static/";
          };
        };
      };
      "roq-wp.dandart.co.uk" = {
        # http3 = true;
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [
          "roq-wp.dandart.uk"
        ];
        extraConfig = ''
          error_page 502 /502.html;
        '';
        locations = {
          "/" = {
            proxyPass = "http://192.168.1.112:5600/";
            proxyWebsockets = true;
          };
          "/502.html" = {
            root = "${hostDir}/roqqett_html";
          };
        };
      };
      "dev.dandart.co.uk" = {
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/dandart";
            proxyWebsockets = true;
          };
        };
      };
      "dev.jolharg.com" = {
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/jolharg";
            proxyWebsockets = true;
          };
        };
      };
      "dev.blog.jolharg.com" = {
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/blogjolharg";
            proxyWebsockets = true;
          };
        };
      };
      "dev.madhackerreviews.com" = {
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/madhacker";
            proxyWebsockets = true;
          };
        };
      };
      "dev.m0ori.com" = {
        #onlySSL = true;
        #enableACME = true;
        serverAliases = [];
        locations = {
          "/" = {
            root = "${websites}/m0ori";
            proxyWebsockets = true;
          };
        };
      };
      "dev.blog.dandart.co.uk" = {
        #onlySSL = true;
        #enableACME = true;
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
        #onlySSL = true;
        #enableACME = true;
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
        #onlySSL = true;
        #enableACME = true;
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
        #onlySSL = true;
        #enableACME = true;
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

  # broken

  #grocy = {
  #  enable = true;
  #  hostName = "grocy.dandart.co.uk";
  #  nginx = {
  #    # #onlySSL = true;
  #  };
  #  settings = {
  #    calendar = {
  #      firstDayOfWeek = 1;
  #    };
  #    currency = "GBP";
  #    culture = "en_GB";
  #  };
  #};

  # home-assistant = {
  #   enable = true;
  #   openFirewall = true;
  #   config = {
  #     homeassistant = {
  #       unit_system = "metric";
  #       time_zone = "Europe/London";
  #       temperature_unit = "C";
  #       name = "sinistra";
  #       longitude = -2.5;
  #       latitude = 51.2;
  #     };
  #   };
  #   extraComponents = [
  #     "abode"
  #     "accuweather"
  #     "acer_projector"
  #     "acmeda"
  #     "actiontec"
  #     "adax"
  #     "adguard"
  #     "ads"
  #     "advantage_air"
  #     "aemet"
  #     "aftership"
  #     "agent_dvr"
  #     "air_quality"
  #     "airly"
  #     "airnow"
  #     "airthings"
  #     "airtouch4"
  #     "airvisual"
  #     "airzone"
  #     "aladdin_connect"
  #     "alarm_control_panel"
  #     "alarmdecoder"
  #     "alert"
  #     "alexa"
  #     "almond"
  #     "alpha_vantage"
  #     "amazon_polly"
  #     "amberelectric"
  #     "ambiclimate"
  #     "ambient_station"
  #     "amcrest"
  #     "ampio"
  #     "analytics"
  #     "android_ip_webcam"
  #     "androidtv"
  #     "anel_pwrctrl"
  #     "anthemav"
  #     "apache_kafka"
  #     "apcupsd"
  #     "api"
  #     "apple_tv"
  #     "application_credentials"
  #     "apprise"
  #     "aprs"
  #     "aqualogic"
  #     "aquostv"
  #     "arcam_fmj"
  #     "arest"
  #     "arris_tg2492lg"
  #     "aruba"
  #     "arwn"
  #     "aseko_pool_live"
  #     "asterisk_cdr"
  #     "asterisk_mbox"
  #     "asuswrt"
  #     "atag"
  #     "aten_pe"
  #     "atome"
  #     "august"
  #     "aurora"
  #     "aurora_abb_powerone"
  #     "aussie_broadband"
  #     "auth"
  #     "automation"
  #     "avea"
  #     "avion"
  #     "awair"
  #     "aws"
  #     "axis"
  #     "azure_devops"
  #     "azure_event_hub"
  #     "azure_service_bus"
  #     "backup"
  #     "baf"
  #     "baidu"
  #     "balboa"
  #     "bayesian"
  #     "bbox"
  #     "beewi_smartclim"
  #     "binary_sensor"
  #     "bitcoin"
  #     "bizkaibus"
  #     "blackbird"
  #     "blebox"
  #     "blink"
  #     "blinksticklight"
  #     "blockchain"
  #     "bloomsky"
  #     "bluemaestro"
  #     "blueprint"
  #     "bluesound"
  #     "bluetooth"
  #     "bluetooth_le_tracker"
  #     "bluetooth_tracker"
  #     "bmw_connected_drive"
  #     "bond"
  #     "bosch_shc"
  #     "braviatv"
  #     "broadlink"
  #     "brother"
  #     "brottsplatskartan"
  #     "browser"
  #     "brunt"
  #     "bsblan"
  #     "bt_home_hub_5"
  #     "bt_smarthub"
  #     "bthome"
  #     "buienradar"
  #     "button"
  #     "caldav"
  #     "calendar"
  #     "camera"
  #     "canary"
  #     "cast"
  #     "cert_expiry"
  #     "channels"
  #     "circuit"
  #     "cisco_ios"
  #     "cisco_mobility_express"
  #     "cisco_webex_teams"
  #     "citybikes"
  #     "clementine"
  #     "clickatell"
  #     "clicksend"
  #     "clicksend_tts"
  #     "climate"
  #     "cloud"
  #     "cloudflare"
  #     "cmus"
  #     "co2signal"
  #     "coinbase"
  #     "color_extractor"
  #     "comed_hourly_pricing"
  #     "comfoconnect"
  #     "command_line"
  #     "compensation"
  #     "concord232"
  #     "config"
  #     "configurator"
  #     "control4"
  #     "conversation"
  #     "coolmaster"
  #     "coronavirus"
  #     "counter"
  #     "cover"
  #     "cppm_tracker"
  #     "cpuspeed"
  #     "crownstone"
  #     "cups"
  #     "currencylayer"
  #     "daikin"
  #     "danfoss_air"
  #     "darksky"
  #     "datadog"
  #     "ddwrt"
  #     "debugpy"
  #     "deconz"
  #     "decora"
  #     "decora_wifi"
  #     "default_config"
  #     "delijn"
  #     "deluge"
  #     "demo"
  #     "denon"
  #     "denonavr"
  #     "derivative"
  #     "deutsche_bahn"
  #     "device_automation"
  #     "device_sun_light_trigger"
  #     "device_tracker"
  #     "devolo_home_control"
  #     "devolo_home_network"
  #     "dexcom"
  #     "dhcp"
  #     "diagnostics"
  #     "dialogflow"
  #     "digital_ocean"
  #     "directv"
  #     "discogs"
  #     "discord"
  #     "discovery"
  #     "dlib_face_detect"
  #     "dlib_face_identify"
  #     "dlink"
  #     "dlna_dmr"
  #     "dlna_dms"
  #     "dnsip"
  #     "dominos"
  #     "doods"
  #     "doorbird"
  #     "dovado"
  #     "downloader"
  #     "dsmr"
  #     "dsmr_reader"
  #     "dte_energy_bridge"
  #     "dublin_bus_transport"
  #     "duckdns"
  #     "dunehd"
  #     "dwd_weather_warnings"
  #     "dweet"
  #     "dynalite"
  #     "eafm"
  #     "ebox"
  #     "ebusd"
  #     "ecoal_boiler"
  #     "ecobee"
  #     "econet"
  #     "ecovacs"
  #     "ecowitt"
  #     "eddystone_temperature"
  #     "edimax"
  #     "edl21"
  #     "efergy"
  #     "egardia"
  #     "eight_sleep"
  #     "elgato"
  #     "eliqonline"
  #     "elkm1"
  #     "elmax"
  #     "elv"
  #     "emby"
  #     "emoncms"
  #     "emoncms_history"
  #     "emonitor"
  #     "emulated_hue"
  #     "emulated_kasa"
  #     "emulated_roku"
  #     "energy"
  #     "enigma2"
  #     "enocean"
  #     "enphase_envoy"
  #     "entur_public_transport"
  #     "environment_canada"
  #     "envisalink"
  #     "ephember"
  #     "epson"
  #     "epsonworkforce"
  #     "eq3btsmart"
  #     "escea"
  #     "esphome"
  #     "etherscan"
  #     "eufy"
  #     "everlights"
  #     "evil_genius_labs"
  #     "evohome"
  #     "ezviz"
  #     "faa_delays"
  #     "facebook"
  #     "facebox"
  #     "fail2ban"
  #     "familyhub"
  #     "fan"
  #     "fastdotcom"
  #     "feedreader"
  #     "ffmpeg"
  #     "ffmpeg_motion"
  #     "ffmpeg_noise"
  #     "fibaro"
  #     "fido"
  #     "file"
  #     "file_upload"
  #     "filesize"
  #     "filter"
  #     "fints"
  #     "fireservicerota"
  #     "firmata"
  #     "fitbit"
  #     "fivem"
  #     "fixer"
  #     "fjaraskupan"
  #     "fleetgo"
  #     "flexit"
  #     "flic"
  #     "flick_electric"
  #     "flipr"
  #     "flo"
  #     "flock"
  #     "flume"
  #     "flux"
  #     "flux_led"
  #     "folder"
  #     "folder_watcher"
  #     "foobot"
  #     "forecast_solar"
  #     "forked_daapd"
  #     "fortios"
  #     "foscam"
  #     "foursquare"
  #     "free_mobile"
  #     "freebox"
  #     "freedns"
  #     "freedompro"
  #     "fritz"
  #     "fritzbox"
  #     "fritzbox_callmonitor"
  #     "fronius"
  #     "frontend"
  #     "frontier_silicon"
  #     "fully_kiosk"
  #     "futurenow"
  #     "garadget"
  #     "garages_amsterdam"
  #     "gc100"
  #     "gdacs"
  #     "generic"
  #     "generic_hygrostat"
  #     "generic_thermostat"
  #     "geniushub"
  #     "geo_json_events"
  #     "geo_location"
  #     "geo_rss_events"
  #     "geocaching"
  #     "geofency"
  #     "geonetnz_quakes"
  #     "geonetnz_volcano"
  #     "gios"
  #     "github"
  #     "gitlab_ci"
  #     "gitter"
  #     "glances"
  #     "goalfeed"
  #     "goalzero"
  #     "gogogate2"
  #     "goodwe"
  #     "google"
  #     "google_assistant"
  #     "google_cloud"
  #     "google_domains"
  #     "google_maps"
  #     "google_pubsub"
  #     "google_sheets"
  #     "google_translate"
  #     "google_travel_time"
  #     "google_wifi"
  #     "govee_ble"
  #     "gpsd"
  #     "gpslogger"
  #     "graphite"
  #     "gree"
  #     "greeneye_monitor"
  #     "greenwave"
  #     "group"
  #     "growatt_server"
  #     "gstreamer"
  #     "gtfs"
  #     "guardian"
  #     "habitica"
  #     "hangouts"
  #     "hardkernel"
  #     "hardware"
  #     "harman_kardon_avr"
  #     "harmony"
  #     "hassio"
  #     "haveibeenpwned"
  #     "hddtemp"
  #     "hdmi_cec"
  #     "heatmiser"
  #     "heos"
  #     "here_travel_time"
  #     "hikvision"
  #     "hikvisioncam"
  #     "hisense_aehw4a1"
  #     "history"
  #     "history_stats"
  #     "hitron_coda"
  #     "hive"
  #     "hlk_sw16"
  #     "home_connect"
  #     "home_plus_control"
  #     "homeassistant"
  #     "homeassistant_alerts"
  #     "homeassistant_sky_connect"
  #     "homeassistant_yellow"
  #     "homekit"
  #     "homekit_controller"
  #     "homematic"
  #     "homematicip_cloud"
  #     "homewizard"
  #     "homeworks"
  #     "honeywell"
  #     "horizon"
  #     "hp_ilo"
  #     "html5"
  #     "http"
  #     "huawei_lte"
  #     "hue"
  #     "huisbaasje"
  #     "humidifier"
  #     "hunterdouglas_powerview"
  #     "hvv_departures"
  #     "hydrawise"
  #     "hyperion"
  #     "ialarm"
  #     "iammeter"
  #     # "iaqualink" # broken
  #     "ibeacon"
  #     "icloud"
  #     "idteck_prox"
  #     "ifttt"
  #     "iglo"
  #     "ign_sismologia"
  #     "ihc"
  #     "image"
  #     "image_processing"
  #     "imap"
  #     "imap_email_content"
  #     "incomfort"
  #     "influxdb"
  #     "inkbird"
  #     "input_boolean"
  #     "input_button"
  #     "input_datetime"
  #     "input_number"
  #     "input_select"
  #     "input_text"
  #     "insteon"
  #     "integration"
  #     "intellifire"
  #     "intent"
  #     "intent_script"
  #     "intesishome"
  #     "ios"
  #     "iotawatt"
  #     "iperf3"
  #     "ipma"
  #     "ipp"
  #     "iqvia"
  #     "irish_rail_transport"
  #     "islamic_prayer_times"
  #     "iss"
  #     "isy994"
  #     "itach"
  #     "itunes"
  #     "izone"
  #     "jellyfin"
  #     "jewish_calendar"
  #     "joaoapps_join"
  #     "juicenet"
  #     "justnimbus"
  #     "kaiterra"
  #     "kaleidescape"
  #     "kankun"
  #     "keba"
  #     "keenetic_ndms2"
  #     "kef"
  #     "kegtron"
  #     "keyboard"
  #     "keyboard_remote"
  #     "keymitt_ble"
  #     "kira"
  #     "kiwi"
  #     "kmtronic"
  #     "knx"
  #     "kodi"
  #     "konnected"
  #     "kostal_plenticore"
  #     "kraken"
  #     "kulersky"
  #     "kwb"
  #     "lacrosse"
  #     "lacrosse_view"
  #     "lametric"
  #     "landisgyr_heat_meter"
  #     "lannouncer"
  #     "lastfm"
  #     "launch_library"
  #     "laundrify"
  #     "lcn"
  #     "led_ble"
  #     "lg_netcast"
  #     "lg_soundbar"
  #     "lidarr"
  #     "life360"
  #     "lifx"
  #     "lifx_cloud"
  #     "light"
  #     "lightwave"
  #     "limitlessled"
  #     "linksys_smart"
  #     "linode"
  #     "linux_battery"
  #     "lirc"
  #     "litejet"
  #     "litterrobot"
  #     "llamalab_automate"
  #     "local_file"
  #     "local_ip"
  #     "locative"
  #     "lock"
  #     "logbook"
  #     "logentries"
  #     "logger"
  #     "logi_circle"
  #     "london_air"
  #     "london_underground"
  #     "lookin"
  #     "lovelace"
  #     "luci"
  #     "luftdaten"
  #     "lupusec"
  #     "lutron"
  #     "lutron_caseta"
  #     "lw12wifi"
  #     "lyric"
  #     "magicseaweed"
  #     "mailbox"
  #     "mailgun"
  #     "manual"
  #     "manual_mqtt"
  #     "map"
  #     "marytts"
  #     "mastodon"
  #     "matrix"
  #     "maxcube"
  #     "mazda"
  #     "meater"
  #     "media_extractor"
  #     "media_player"
  #     "media_source"
  #     "mediaroom"
  #     "melcloud"
  #     "melissa"
  #     "melnor"
  #     "meraki"
  #     "message_bird"
  #     "met"
  #     "met_eireann"
  #     "meteo_france"
  #     "meteoalarm"
  #     "meteoclimatic"
  #     "metoffice"
  #     "mfi"
  #     "microsoft"
  #     "microsoft_face"
  #     "microsoft_face_detect"
  #     "microsoft_face_identify"
  #     "miflora"
  #     "mikrotik"
  #     "mill"
  #     "min_max"
  #     "minecraft_server"
  #     "minio"
  #     "mitemp_bt"
  #     "mjpeg"
  #     "moat"
  #     "mobile_app"
  #     "mochad"
  #     "modbus"
  #     "modem_callerid"
  #     "modern_forms"
  #     "moehlenhoff_alpha2"
  #     "mold_indicator"
  #     "monoprice"
  #     "moon"
  #     "motion_blinds"
  #     "motioneye"
  #     "mpd"
  #     "mqtt"
  #     "mqtt_eventstream"
  #     "mqtt_json"
  #     "mqtt_room"
  #     "mqtt_statestream"
  #     "msteams"
  #     "mullvad"
  #     "mutesync"
  #     "mvglive"
  #     "my"
  #     "mycroft"
  #     "myq"
  #     "mysensors"
  #     "mystrom"
  #     "mythicbeastsdns"
  #     "nad"
  #     "nam"
  #     "namecheapdns"
  #     "nanoleaf"
  #     "neato"
  #     "nederlandse_spoorwegen"
  #     "ness_alarm"
  #     "nest"
  #     "netatmo"
  #     "netdata"
  #     "netgear"
  #     "netgear_lte"
  #     "netio"
  #     "network"
  #     "neurio_energy"
  #     "nexia"
  #     "nextbus"
  #     "nextcloud"
  #     "nextdns"
  #     "nfandroidtv"
  #     "nibe_heatpump"
  #     "nightscout"
  #     "niko_home_control"
  #     "nilu"
  #     "nina"
  #     "nissan_leaf"
  #     "nmap_tracker"
  #     "nmbs"
  #     "no_ip"
  #     "noaa_tides"
  #     "nobo_hub"
  #     "norway_air"
  #     "notify"
  #     "notify_events"
  #     "notion"
  #     "nsw_fuel_station"
  #     "nsw_rural_fire_service_feed"
  #     "nuheat"
  #     "nuki"
  #     "numato"
  #     "number"
  #     "nut"
  #     "nws"
  #     "nx584"
  #     "nzbget"
  #     "oasa_telematics"
  #     "obihai"
  #     "octoprint"
  #     "oem"
  #     "ohmconnect"
  #     "ombi"
  #     "omnilogic"
  #     "onboarding"
  #     "oncue"
  #     "ondilo_ico"
  #     "onewire"
  #     "onkyo"
  #     "onvif"
  #     "open_meteo"
  #     "openalpr_cloud"
  #     "openalpr_local"
  #     "opencv"
  #     "openerz"
  #     "openevse"
  #     "openexchangerates"
  #     "opengarage"
  #     "openhardwaremonitor"
  #     "openhome"
  #     "opensensemap"
  #     "opensky"
  #     "opentherm_gw"
  #     "openuv"
  #     "openweathermap"
  #     "opnsense"
  #     "opple"
  #     "oru"
  #     "orvibo"
  #     "osramlightify"
  #     "otp"
  #     "overkiz"
  #     "ovo_energy"
  #     "owntracks"
  #     "p1_monitor"
  #     "panasonic_bluray"
  #     "panasonic_viera"
  #     "pandora"
  #     "panel_custom"
  #     "panel_iframe"
  #     "peco"
  #     "pencom"
  #     "persistent_notification"
  #     "person"
  #     "philips_js"
  #     "pi_hole"
  #     "picnic"
  #     "picotts"
  #     "pilight"
  #     "ping"
  #     "pioneer"
  #     "pjlink"
  #     "plaato"
  #     "plant"
  #     "plex"
  #     "plugwise"
  #     "plum_lightpad"
  #     "pocketcasts"
  #     "point"
  #     "poolsense"
  #     "powerwall"
  #     "profiler"
  #     "progettihwsw"
  #     "proliphix"
  #     "prometheus"
  #     "prosegur"
  #     "prowl"
  #     "proximity"
  #     "proxmoxve"
  #     "proxy"
  #     "prusalink"
  #     "ps4"
  #     "pulseaudio_loopback"
  #     "pure_energie"
  #     "push"
  #     "pushbullet"
  #     "pushover"
  #     "pushsafer"
  #     "pvoutput"
  #     "pvpc_hourly_pricing"
  #     "pyload"
  #     "python_script"
  #     "qbittorrent"
  #     "qingping"
  #     "qld_bushfire"
  #     "qnap"
  #     "qnap_qsw"
  #     "qrcode"
  #     "quantum_gateway"
  #     "qvr_pro"
  #     "qwikswitch"
  #     "rachio"
  #     "radarr"
  #     "radio_browser"
  #     "radiotherm"
  #     "rainbird"
  #     "raincloud"
  #     "rainforest_eagle"
  #     "rainmachine"
  #     "random"
  #     "raspberry_pi"
  #     "raspyrfm"
  #     "rdw"
  #     "recollect_waste"
  #     "recorder"
  #     "recswitch"
  #     "reddit"
  #     "rejseplanen"
  #     "remember_the_milk"
  #     "remote"
  #     "remote_rpi_gpio"
  #     "renault"
  #     "repairs"
  #     "repetier"
  #     "rest"
  #     "rest_command"
  #     "rflink"
  #     "rfxtrx"
  #     "rhasspy"
  #     "ridwell"
  #     "ring"
  #     "ripple"
  #     "risco"
  #     "rituals_perfume_genie"
  #     "rmvtransport"
  #     "rocketchat"
  #     "roku"
  #     "roomba"
  #     "roon"
  #     "route53"
  #     "rova"
  #     "rpi_camera"
  #     "rpi_power"
  #     "rss_feed_template"
  #     "rtorrent"
  #     "rtsp_to_webrtc"
  #     "ruckus_unleashed"
  #     "russound_rio"
  #     "russound_rnet"
  #     "sabnzbd"
  #     "safe_mode"
  #     "saj"
  #     "samsungtv"
  #     "satel_integra"
  #     "scene"
  #     "schedule"
  #     "schluter"
  #     "scrape"
  #     "screenlogic"
  #     "script"
  #     "scsgate"
  #     "search"
  #     "season"
  #     "select"
  #     "sendgrid"
  #     "sense"
  #     "senseme"
  #     "sensibo"
  #     "sensor"
  #     "sensorpro"
  #     "sensorpush"
  #     "sentry"
  #     "senz"
  #     "serial"
  #     "serial_pm"
  #     "sesame"
  #     "seven_segments"
  #     "seventeentrack"
  #     "sharkiq"
  #     "shell_command"
  #     "shelly"
  #     "shiftr"
  #     "shodan"
  #     "shopping_list"
  #     "sia"
  #     "sigfox"
  #     "sighthound"
  #     "signal_messenger"
  #     "simplepush"
  #     "simplisafe"
  #     "simulated"
  #     "sinch"
  #     "siren"
  #     "sisyphus"
  #     "sky_hub"
  #     "skybeacon"
  #     "skybell"
  #     "slack"
  #     "sleepiq"
  #     "slide"
  #     "slimproto"
  #     "sma"
  #     "smappee"
  #     "smart_meter_texas"
  #     "smartthings"
  #     "smarttub"
  #     "smarty"
  #     "smhi"
  #     "sms"
  #     "smtp"
  #     "snapcast"
  #     "snips"
  #     "snmp"
  #     "solaredge"
  #     "solaredge_local"
  #     "solarlog"
  #     "solax"
  #     "soma"
  #     "somfy_mylink"
  #     "sonarr"
  #     "songpal"
  #     "sonos"
  #     "sony_projector"
  #     "soundtouch"
  #     "spaceapi"
  #     "spc"
  #     "speedtestdotnet"
  #     "spider"
  #     "splunk"
  #     "spotify"
  #     "sql"
  #     "squeezebox"
  #     "srp_energy"
  #     "ssdp"
  #     "starline"
  #     "starlingbank"
  #     "startca"
  #     "statistics"
  #     "statsd"
  #     "steam_online"
  #     "steamist"
  #     "stiebel_eltron"
  #     "stookalert"
  #     "stream"
  #     "streamlabswater"
  #     "stt"
  #     "subaru"
  #     "suez_water"
  #     "sun"
  #     "supervisord"
  #     "supla"
  #     "surepetcare"
  #     "swiss_hydrological_data"
  #     "swiss_public_transport"
  #     "swisscom"
  #     "switch"
  #     "switch_as_x"
  #     "switchbee"
  #     "switchbot"
  #     "switcher_kis"
  #     "switchmate"
  #     "syncthing"
  #     "syncthru"
  #     "synology_chat"
  #     "synology_dsm"
  #     "synology_srm"
  #     "syslog"
  #     "system_bridge"
  #     "system_health"
  #     "system_log"
  #     "systemmonitor"
  #     "tado"
  #     "tag"
  #     "tailscale"
  #     "tank_utility"
  #     "tankerkoenig"
  #     "tapsaff"
  #     "tasmota"
  #     "tautulli"
  #     "tcp"
  #     "ted5000"
  #     "telegram"
  #     "telegram_bot"
  #     "tellduslive"
  #     "tellstick"
  #     "telnet"
  #     "temper"
  #     "template"
  #     "tensorflow"
  #     "tesla_wall_connector"
  #     "tfiac"
  #     "thermobeacon"
  #     "thermopro"
  #     "thermoworks_smoke"
  #     "thethingsnetwork"
  #     "thingspeak"
  #     "thinkingcleaner"
  #     "thomson"
  #     "threshold"
  #     "tibber"
  #     "tikteck"
  #     "tile"
  #     "tilt_ble"
  #     "time_date"
  #     "timer"
  #     "tmb"
  #     "tod"
  #     "todoist"
  #     "tolo"
  #     "tomato"
  #     "tomorrowio"
  #     "toon"
  #     "torque"
  #     "totalconnect"
  #     "touchline"
  #     "tplink"
  #     "tplink_lte"
  #     "traccar"
  #     "trace"
  #     "tractive"
  #     "tradfri"
  #     "trafikverket_ferry"
  #     "trafikverket_train"
  #     "trafikverket_weatherstation"
  #     "transmission"
  #     "transport_nsw"
  #     "travisci"
  #     "trend"
  #     "tts"
  #     "tuya"
  #     "twentemilieu"
  #     "twilio"
  #     "twilio_call"
  #     "twilio_sms"
  #     "twinkly"
  #     "twitch"
  #     "twitter"
  #     "ubus"
  #     "ue_smart_radio"
  #     "uk_transport"
  #     "ukraine_alarm"
  #     "unifi"
  #     "unifi_direct"
  #     "unifiled"
  #     "unifiprotect"
  #     "universal"
  #     "upb"
  #     "upc_connect"
  #     "upcloud"
  #     "update"
  #     "upnp"
  #     "uptime"
  #     "uptimerobot"
  #     "usb"
  #     "usgs_earthquakes_feed"
  #     "utility_meter"
  #     "uvc"
  #     "vacuum"
  #     "vallox"
  #     "vasttrafik"
  #     "velbus"
  #     "velux"
  #     "venstar"
  #     "vera"
  #     "verisure"
  #     "versasense"
  #     "version"
  #     "vesync"
  #     "viaggiatreno"
  #     "vicare"
  #     "vilfo"
  #     "vivotek"
  #     "vizio"
  #     "vlc"
  #     "vlc_telnet"
  #     "voicerss"
  #     "volkszaehler"
  #     "volumio"
  #     "volvooncall"
  #     "vulcan"
  #     "vultr"
  #     "w800rf32"
  #     "wake_on_lan"
  #     "wallbox"
  #     "waqi"
  #     "water_heater"
  #     "waterfurnace"
  #     "watson_iot"
  #     "watson_tts"
  #     "watttime"
  #     "waze_travel_time"
  #     "weather"
  #     "webhook"
  #     "webostv"
  #     "websocket_api"
  #     "wemo"
  #     "whirlpool"
  #     "whois"
  #     "wiffi"
  #     "wilight"
  #     "wirelesstag"
  #     "withings"
  #     "wiz"
  #     "wled"
  #     "wolflink"
  #     "workday"
  #     "worldclock"
  #     "worldtidesinfo"
  #     "worxlandroid"
  #     "ws66i"
  #     "wsdot"
  #     "x10"
  #     "xbox"
  #     "xbox_live"
  #     "xeoma"
  #     "xiaomi"
  #     "xiaomi_aqara"
  #     "xiaomi_ble"
  #     "xiaomi_miio"
  #     "xiaomi_tv"
  #     "xmpp"
  #     "xs1"
  #     "yale_smart_alarm"
  #     "yalexs_ble"
  #     "yamaha"
  #     "yamaha_musiccast"
  #     "yandex_transport"
  #     "yandextts"
  #     "yeelight"
  #     "yeelightsunflower"
  #     "yi"
  #     "yolink"
  #     "youless"
  #     "zabbix"
  #     "zamg"
  #     "zengge"
  #     "zeroconf"
  #     "zerproc"
  #     "zestimate"
  #     "zha"
  #     "zhong_hong"
  #     "ziggo_mediabox_xl"
  #     "zodiac"
  #     "zone"
  #     "zoneminder"
  #   ];
  # };

  # synergy = {
  #   server = {
  #     enable = true;
  #     screenName = "sinistra";
  #   };
  # };

  #plex = {
  #  enable = true;
  #  package = pkgs.plex;
  #  openFirewall = true;
  #};

  # perm issues
  #nextcloud = {
  #  enable = true;
  #  package = pkgs.nextcloud24;
  #  https = true;
  #  hostName = "nextcloud.dandart.co.uk";
  #  webfinger = true;
  #  config = {
  #    dbtype = "pgsql";
  #    dbhost = "localhost";
  #    dbname = "nextcloud";
  #    dbuser = "nextcloud";
  #    dbpassFile = "${privateDir}/nextcloud/dbpass";
  #    adminuser = "root";
  #    adminpassFile = "${privateDir}/nextcloud/adminpass";
  #    defaultPhoneRegion = "GB";
  #    overwriteProtocol = "https";
  #  };
  #  autoUpdateApps = {
  #    enable = true;
  #  };
  #};

  postgresql = let
    nextcloudPassword = builtins.readFile "${privateDir}/nextcloud/dbpass";
    msfPassword = builtins.readFile "${privateDir}/msf/dbpass";
    ttrssPassword = builtins.readFile "${privateDir}/tt-rss/dbpass";
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
      CREATE ROLE tt_rss WITH LOGIN PASSWORD '${ttrssPassword}' CREATEDB;
      CREATE DATABASE tt_rss;
      GRANT ALL PRIVILEGES ON DATABASE tt_rss TO tt_rss;
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
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  postfix = {
    enable = true;
    domain = "${hostName}.jolharg.com";
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
      "${hostName}.jolharg.com"
      "jolharg.com"
    ];
    setSendmail = true;
    virtual = ''
      @${hostName} dan@dandart.co.uk
      @${hostName}.jolharg.com dan@dandart.co.uk
    '';
  };

  printing.enable = true;

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

  joycond.enable = true;

  clamav = {
    updater = {
      enable = true;
      interval = "*/30 * * * *";
      frequency = 48;
      settings = {
        SafeBrowsing = true;
      };
    };
    daemon = {
      enable = true;
      settings = {

      };
    };
  };
}

{ pkgs, isDesktop, ...}:
{
  steam = if builtins.currentSystem == "x86_64-linux" && isDesktop then {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  } else {};

  adb.enable = true;

  dconf.enable = true;

  # mkSystemd missing???
  # atop = {
  #   enable = true;
  #   # netatop = {
  #   #   enable = true;
  #   # };
  #   setuidWrapper = {
  #     enable = true;
  #   };
  # };

  wireshark.enable = isDesktop;

  iftop.enable = true;

  iotop.enable = true;

  fuse.userAllowOther = true;

  partition-manager.enable = isDesktop;

  soundmodem.enable = isDesktop;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  mtr.enable = true;

  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # nethoscope.enable = true;

  # nix-ld = {
  #   enable = true; # breaks ls in nix shells!?
  #   # Sets up all the libraries to load
  #   libraries = with pkgs; [
  #     stdenv.cc.cc
  #     zlib
  #     fuse3
  #     icu
  #     zlib
  #     nss
  #     openssl
  #     curl
  #     expat
  #   ];
  # };

  # big
  # darling.enable = true;

  # zsh = {
  #   enable = true;
  #   ohMyZsh = {
  #     enable = true;
  #     plugins = [ "git" "man" ];
  #     # theme = "agnoster";
  #   };
  # };

  firefox = {
    enable = true;
    # error: attribute 'nameValuePair' missing
    # languagePacks = [ "en-GB" ];
    preferences = {
      "browser.contentblocking.category" = "strict";
      "browser.protections_panel.infoMessage.seen" = true;
      "browser.rights.3.shown" = true;
      "network.trr.mode" = 3;
      "network.trr.custom_uri" = "https://doh.kekew.info/dns-query";
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.globalprivacycontrol.enabled" = true;
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
    };
  };

  gamemode = {
    enable = true;
    enableRenice = true;
  };

  # basically be steamos WM
  gamescope = {
    enable = true;
  };

  htop = {
    enable = true;
    settings = {};
  };

  kdeconnect = {
    enable = true; # auto open firewall
  };

  screen = {
    enable = true;
    screenrc = ''
    '';
  };

  wavemon = {
    enable = true;
  };

  xastir = {
    enable = true;
  };
}

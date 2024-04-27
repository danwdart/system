{ pkgs, isDesktop, ...}:
{
  steam.enable = builtins.currentSystem == "x86_64-linux" && isDesktop;

  adb.enable = true;

  atop = {
    enable = true;
    # netatop = {
    #   enable = true;
    # };
    setuidWrapper = {
      enable = true;
    };
  };

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
    languagePacks = [ "en-GB" ];
    # preferences = [ ];
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

{pkgs, ...}:
{
  steam.enable = if builtins.currentSystem != "aarch64-linux" then true else false;

  adb.enable = true;

  wireshark.enable = true;

  iotop.enable = true;

  fuse.userAllowOther = true;

  partition-manager.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  mtr.enable = true;

  gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # nethoscope.enable = true;

  nix-ld = {
    enable = true; # breaks ls in nix shells!?
    # Sets up all the libraries to load
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      zlib
      nss
      openssl
      curl
      expat
    ];
  };

  # needs master
  # darling.enable = true;
}

{ pkgs, isDesktop, ...}:
{
  steam.enable = builtins.currentSystem != "aarch64-linux" && isDesktop;

  adb.enable = true;

  wireshark.enable = isDesktop;

  iotop.enable = true;

  fuse.userAllowOther = true;

  partition-manager.enable = isDesktop;

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

  # needs master
  # darling.enable = true;
}

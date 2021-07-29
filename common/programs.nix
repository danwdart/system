{...}:
{
  steam.enable = true;

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
}
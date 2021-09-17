{ unstable, ... }:
{
  loader.systemd-boot.enable = true;
  loader.systemd-boot.memtest86.enable = true;
  
  loader.efi.canTouchEfiVariables = true;

  kernel.sysctl = {
    # all magic sysrq keys
    "kernel.sysrq" = 1;
    # Fix some apps, see bug https://github.com/NixOS/nixpkgs/issues/110468
    # Specifically needed for hardened kernels
    "kernel.unprivileged_userns_clone" = 1;
    # try not to use swap
    "vm.swappiness" = 0;
  };

  # linuxPackages_latest
  
  # unstable.linuxPackages_latest_hardened
  # master.linuxPackages_5_13_hardened

  # https://liquorix.net/
  # linuxPackages_lqx

  # https://www.osadl.org/Realtime-Linux.projects-realtime-linux.0.html
  # linuxPackages-rt_latest
  # linuxPackages_rt_5_11

  # https://xanmod.org/
  # linuxPackages_xanmod

  # https://github.com/zen-kernel/zen-kernel
  # linuxPackages_zen

  kernelPackages = unstable.linuxPackages_latest_hardened;

  plymouth.enable = true;
}

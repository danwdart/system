{ pkgs, unstable, ...}:
{
  loader.systemd-boot = {
    enable = true;
    editor = false;
    memtest86.enable = true;
    configurationLimit = 3;
  };

  # for rescue purposes, copy 
  #loader.generationsDir = {
    # link latest generation to /boot/default/kernel and /boot/default/initrd
  #  enable = true;
    # copy kernels to /boot so there's no need for /nix/store
  #  copyKernels = true;
  #};

  loader.efi.canTouchEfiVariables = true;
  loader.efi.efiSysMountPoint = "/boot/efi";

  kernel.sysctl = {
    # all magic sysrq keys
    "kernel.sysrq" = 1;
    # Fix some apps, see bug https://github.com/NixOS/nixpkgs/issues/110468
    # Specifically needed for hardened kernels
    "kernel.unprivileged_userns_clone" = 1;
    # try to use zram first
    "vm.swappiness" = 100;
  };

  # linuxPackages_latest
  
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

  kernelPackages = unstable.linuxPackages_5_18_hardened;

  plymouth.enable = true;
}

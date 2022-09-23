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

  # linuxKernel.packages.linux_rt_5_10 = 5.10.140

  # linuxKernel.packages.linux_hardened = 5.15.67

  # https://xanmod.org/
  # linuxKernel.packages.linux_xanmod)latest = 5.18.11

  # linuxKernel.packages.linux_5_19 = 5.19.9

  # https://liquorix.net/
  # linuxKernel.packages.linux_lqx = 5.19.10 # same as zen but less aggressive release schedule

  # https://github.com/zen-kernel/zen-kernel
  # linuxKernel.packages.linux_zen = 5.19.10

  kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  plymouth.enable = true;
}

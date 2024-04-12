{ pkgs, ...}:
{
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

  kernelPackages = pkgs.linuxKernel.packages.linux_6_8;

  #kernelPatches = [
  #  {
  #    name = "generic switch pro controller support";
  #    patch = builtins.fetchurl "https://github.com/DanielOgorchock/linux/files/9727518/generic-pro-controller.log";
  #  }
  #];

  plymouth = {
    enable = true;
  };
  
  # If you want anything for this built by nixosm, you have to use --argstr system X
  binfmt.emulatedSystems = [
    "i686-linux"
    # "x86_64-linux"
    # "x86_64-windows"
    "wasm32-wasi"
    "wasm64-wasi"
  ];
}

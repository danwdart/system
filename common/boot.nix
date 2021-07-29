{ ... }:
let
  unstable = import <unstable> {};
in
{
  loader.systemd-boot.enable = true;
  loader.systemd-boot.memtest86.enable = true;
  
  loader.efi.canTouchEfiVariables = true;

  kernel.sysctl = {
    # all magic sysrq keys
    "kernel.sysrq" = 1;
    # try not to use swap
    "vm.swappiness" = 0;
  };

  kernelPackages = unstable.linuxPackages_latest_hardened;

  plymouth.enable = true;
}

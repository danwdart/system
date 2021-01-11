# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "firewire_ohci" "sd_mod" "sr_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/"
        "noatime"
      ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/AF63-BFB6";
      fsType = "vfat";
    };

  swapDevices = [{ device = "/swap"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

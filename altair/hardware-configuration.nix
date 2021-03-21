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
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-intel" "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [
        "size=2G"
      ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/nix"
        "noatime"
      ];
    };
  
  fileSystems."/etc/ssh" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/etc/ssh"
        "noatime"
      ];
    };

  fileSystems."/etc/NetworkManager" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/etc/NetworkManager"
        "noatime"
      ];
    };
  
  fileSystems."/var/lib" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/var/lib"
        "noatime"
      ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/home"
        "noatime"
      ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/39fbc4f6-3693-4c8f-9c86-0e6f2120b968";
      fsType = "btrfs";
      options = [
        "subvol=/swap"
        "nodatacow"
        "noatime"
      ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/AF63-BFB6";
      fsType = "vfat";
    };

  swapDevices = [
    {
      device = "/swap/swap"; # remember to touch & chattr +C
      size = 16 * 1024;
    }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "userspace";

  services.btrfs.autoScrub.enable = true;
}

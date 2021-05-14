# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
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
    { device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/nix"
        "noatime"
      ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/860D-1A99";
      fsType = "vfat";
    };

  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/8651-F5D8";
  #     fsType = "vfat";
  #   };

  fileSystems."/etc/ssh" =
    {
      device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/etc/ssh"
        "noatime"
      ];
    };

  fileSystems."/etc/NetworkManager" =
    {
      device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/etc/NetworkManager"
        "noatime"
      ];
    };
  
  fileSystems."/var/lib" =
    {
      device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/var/lib"
        "noatime"
      ];
    };

  fileSystems."/home" =
    {
      device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/home"
        "noatime"
      ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/sda3";
      fsType = "btrfs";
      options = [
        "subvol=/swap"
        "nodatacow"
        "noatime"
      ];
    };

  
  swapDevices = [
    {
      device = "/swap/swap"; # remember to touch & chattr +C
      size = 4 * 1024;
    }
  ];


  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}

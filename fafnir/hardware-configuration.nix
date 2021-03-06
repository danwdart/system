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
    { device = "/dev/disk/by-uuid/9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
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

  fileSystems."/etc/ssh" =
    {
      device = "/dev/disk/by-uuid/9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
      fsType = "btrfs";
      options = [
        "subvol=/etc/ssh"
        "noatime"
      ];
    };

  fileSystems."/etc/NetworkManager" =
    {
      device = "/dev/disk/by-uuid/9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
      fsType = "btrfs";
      options = [
        "subvol=/etc/NetworkManager"
        "noatime"
      ];
    };
  
  fileSystems."/var/lib" =
    {
      device = "/dev/disk/by-uuid/9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
      fsType = "btrfs";
      options = [
        "subvol=/var/lib"
        "noatime"
      ];
    };

  fileSystems."/persist" =
    {
      device = "/dev/disk/by-uuid/9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
      fsType = "btrfs";
      options = [
        "subvol=/persist"
        "noatime"
      ];
    };

  #environment.persistence."/persist-no-backup" = {
  #  directories = [
  #    "/nix"
  #  ];
  #  files = [
  #  ];
  #};

  #environment.persistence."/persist" = {
  #  directories = [
  #    "/etc/ssh"
  #    "/etc/NetworkManager"
  #  ];
  #  files = [
  #  ];
  #};
  
  swapDevices = [
    {
      device = "/dev/disk/by-uuid/55f0c8d9-20d2-4af1-a586-25e8a97847e4";
    }
  ];


  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}

# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
let
  device = uuid: "/dev/disk/by-uuid/${uuid}";
  btrfsDevice = device "9b7beb2f-1f4d-49e7-990d-1dab4f611fa7";
  bootDevice = device "860D-1A99";
  swapDevice = device "55f0c8d9-20d2-4af1-a586-25e8a97847e4";
  btrfsMount = subvol: {
    device = btrfsDevice;
    fsType = "btrfs";
    options = [
      "subvol=${subvol}"
      "device=${btrfsDevice}"
      "noatime"
    ];
    neededForBoot = true;
  };
  bootMount = {
    device = bootDevice;
    fsType = "vfat";
  };
  rootMount = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "size=4G"
    ];
  };
in
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  
  fileSystems = {
    "/" = rootMount;
    # not in persistence because we don't want to back it up
    "/nix" = btrfsMount "/nix";
    "/boot" = bootMount;
    # TODO move to persistence
    "/var/lib" = btrfsMount "/var/lib";
    "/persist" = btrfsMount "/persist";
  };

  swapDevices = [
    {
      device = swapDevice;
    }
  ];

  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/etc/NetworkManager"
      # "/var/lib"
    ];
    files = [
    ];
  };
  

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}

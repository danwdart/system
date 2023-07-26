# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/78e2a4fc-e283-4d74-a5d5-81c62c35645c";
      fsType = "btrfs";
      options = [ "subvol=@" "noatime" ];
    };

  specialisation.home-on-sd.configuration.fileSystems."/home" = {
    device = "/dev/disk/by-uuid/658db87e-afd8-45f2-bba1-3acf79691860";
    fsType = "btrfs";
    options = [ "subvol=home" "noatime" ];
  };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/F673-C7F9";
      fsType = "vfat";
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s2.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}

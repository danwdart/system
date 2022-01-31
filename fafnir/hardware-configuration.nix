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
      "/home/dwd/Android"
      "/home/dwd/Calibre Library"
      "/home/dwd/code"
      "/home/dwd/Desktop"
      "/home/dwd/Documents"
      "/home/dwd/Downloads"
      "/home/dwd/from"
      "/home/dwd/games"
      "/home/dwd/Music"
      "/home/dwd/Pictures"
      "/home/dwd/qsstv"
      "/home/dwd/radioimages"
      "/home/dwd/Templates" # Really? I don't even use that. But should I? There's no harm...
      "/home/dwd/Videos"
      "/home/dwd/VirtualBox VMs" # TODO remove
      "/home/dwd/VMs"
      "/home/dwd/.android"
      "/home/dwd/.armagetronad"
      "/home/dwd/.cache/spotify" # Keep me logged in
      "/home/dwd/.config/autostart"
      "/home/dwd/.config/cachix"
      "/home/dwd/.config/calibre" 
      "/home/dwd/.config/discord"
      "/home/dwd/.config/doctl"
      "/home/dwd/.config/dolphin-emu"
      "/home/dwd/.config/Element"
      "/home/dwd/.config/gh"
      "/home/dwd/.config/Gpredict"
      "/home/dwd/.config/htop"
      "/home/dwd/.config/Insomnia"
      "/home/dwd/.config/kdeconnect"
      "/home/dwd/.config/Microsoft/Microsoft Teams"
      "/home/dwd/.config/nethack"
      "/home/dwd/.config/Nextcloud"
      "/home/dwd/.config/ON4QZ" # qsstv
      "/home/dwd/.config/PCSX2"
      "/home/dwd/.config/Postman"
      "/home/dwd/.config/rclone"
      "/home/dwd/.config/spotify" # cache as well?
      "/home/dwd/.config/Slack"
      "/home/dwd/.config/VirtualBox" # TODO move?
      "/home/dwd/.dosbox"
      "/home/dwd/.fldigi"
      "/home/dwd/.flrig"
      "/home/dwd/.frozen-bubble"
      "/home/dwd/.ghc"
      "/home/dwd/.gnupg"
      "/home/dwd/.googleearth"
      "/home/dwd/.kde"
      "/home/dwd/.lgames"
      "/home/dwd/.local/share/citra-emu"
      "/home/dwd/.local/share/direnv"
      "/home/dwd/.local/share/dolphin-emu"
      "/home/dwd/.local/share/ktorrent"
      "/home/dwd/.local/share/kwalletd"
      "/home/dwd/.local/share/networkmanagement"
      "/home/dwd/.local/share/Steam"
      "/home/dwd/.local/share/WSJT-X"
      "/home/dwd/.mozilla"
      "/home/dwd/.pcsxr"
      "/home/dwd/.quakespasm"
      "/home/dwd/.serverless"
      "/home/dwd/.ssh"
      "/home/dwd/.steam" # TODO copy/link, don't mount
      "/home/dwd/.thunderbird"
      "/home/dwd/.vagrant.d" # TODO relocate
      "/home/dwd/.vkquake"
      "/home/dwd/.wine"
      "/home/dwd/.yq2"
    ];
    files = [
      "/home/dwd/.bash_history"
      "/home/dwd/.config/dolphinrc"
      "/home/dwd/.config/kdeglobals"
      "/home/dwd/.config/ktorrentrc"
      "/home/dwd/.config/mimeapps.list"
      "/home/dwd/.config/plasma-org.kde.plasma.desktop-appletsrc"
      "/home/dwd/.config/plasmarc"
      "/home/dwd/.config/plasmashellrc"
      "/home/dwd/.config/powermanagementprofilesrc"
      "/home/dwd/.config/WSJT-X.ini"
      "/home/dwd/.local/share/user-places.xbel"
      "/home/dwd/.serverlessrc"
    ];
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}

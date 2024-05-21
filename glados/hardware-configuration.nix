# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "uas" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  fileSystems."/" = lib.mkDefault
    { device = "/dev/disk/by-uuid/1778de2b-8859-4988-9fed-cbd53b8fb7cf";
      fsType = "ext4";
      options = [ "noatime" ];
    };

  fileSystems."/efi" =
    { device = "/dev/disk/by-uuid/18A6-ECFF";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9C62-E073";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ ];
  
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    # numDevices = 1; # Using ZRAM devices as general purpose ephemeral block devices is no longer supported
    swapDevices = 1;
    memoryPercent = 50;
  };

  specialisation.ramdisk.configuration = {
    fileSystems."/" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [
        "size=16G"
      ];
    };

    fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/1778de2b-8859-4988-9fed-cbd53b8fb7cf";
      fsType = "ext4";
      neededForBoot = true;
      options = [ "noatime" ];
    };

    environment.persistence."/persist" = {
      directories = [
        "/etc/ssh"
        "/etc/NetworkManager"
        "/var/lib"
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
        "/home/dwd/VMs"
        "/home/dwd/.android"
        "/home/dwd/.armagetronad"
        "/home/dwd/.azure" # for work, TODO split out?
        "/home/dwd/.cache/nix" # Stop having to keep redownloading tarballs and search indices
        "/home/dwd/.cache/spotify" # Keep me logged in
        "/home/dwd/.config/autostart"
        "/home/dwd/.config/cachix"
        "/home/dwd/.config/calibre"
        "/home/dwd/.config/Code/Backups" # Unsaved open files and workspaces
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
        # "/home/dwd/.ngrok2"
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
        "/root/.cache/nix" # for when rebuilding the system
        "/nix"
      ];
      files = [
        "/etc/machine-id"
        "/home/dwd/.bash_history"
        "/home/dwd/.config/Code/storage.json" # Open files and workspaces
        "/home/dwd/.config/Code/User/globalStorage/state.vscdb" # Current state
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
        "/home/dwd/.nix-channels"
        "/home/dwd/.serverlessrc"
        # "/root/.nix-channels" # keeps dying
      ];
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.docker0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

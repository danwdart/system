{ pkgs, modulesPath, ... }:
{
    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

    boot.loader.grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
        copyKernels = false;
        efiInstallAsRemovable = true;
        configurationLimit = 1;
    };
    #boot.loader.systemd-boot = {
    #    enable = true;
    #    graceful = true;
    #};
    fileSystems."/boot" = { device = "/dev/disk/by-uuid/9767-AD89"; fsType = "vfat"; };
    boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" ];
    boot.initrd.kernelModules = [ "nvme" ];
    fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; options = [ "noatime" ]; };
    # swapDevices = [
    #     {
    #         device = "/var/swap";
    #         size = "
    #     }
    zramSwap = {
        enable = true;
        algorithm = "zstd";
        # numDevices = 1; # Using ZRAM devices as general purpose ephemeral block devices is no longer supported
        swapDevices = 1;
        memoryPercent = 50;
    };
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_5;
}

{ pkgs, modulesPath, ... }:
{
    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

    boot.loader.grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
        copyKernels = false;
        efiInstallAsRemovable = true;
    };
    #boot.loader.systemd-boot = {
    #    enable = true;
    #    graceful = true;
    #};
    fileSystems."/boot" = { device = "/dev/disk/by-uuid/9767-AD89"; fsType = "vfat"; };
    boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" ];
    boot.initrd.kernelModules = [ "nvme" ];
    fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };
    # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_4;
}

{ pkgs, ... }:
with pkgs; [
    libguestfs-with-appliance
    OVMF
    qemu
    virglrenderer
    # virtinst
    virt-manager
    # virt-manager-qt
    virt-viewer
    win-qemu
]
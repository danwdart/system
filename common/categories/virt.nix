{ pkgs, ... }:
with pkgs; [
    libguestfs-with-appliance
    OVMF
    qemu
    virglrenderer
    # virtinst
    virt-manager
    # virt-manager-qt
    virt-viewer # no desktop icon
    win-qemu
]
{ pkgs, ... }:
with pkgs; [
    libguestfs-with-appliance
    OVMF
    OVMF-CSM
    OVMF-secureBoot
    qemu
    virglrenderer
    # virtinst
    virt-manager
    # virt-manager-qt
    virt-viewer # no desktop icon
    win-qemu
]
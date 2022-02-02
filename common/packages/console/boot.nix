pkgs:
with pkgs; [
    # beefi
    efibootmgr
    efitools
    efivar
    sbsigntool
    uefi-firmware-parser
    uefitool
    uefitoolPackages.new-engine
    uefitoolPackages.old-engine
]

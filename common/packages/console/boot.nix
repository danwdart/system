pkgs:
with pkgs; [
    # beefi
    efibootmgr
    # efitools # broken on aarch64
    efivar
    sbsigntool
    uefi-firmware-parser
    uefitool
    uefitoolPackages.new-engine
    uefitoolPackages.old-engine
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    efitools
] else [

])

pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    # beefi
    efibootmgr
    # efitools # broken on aarch64
    efivar
    sbctl
    sbsigntool
    uefi-firmware-parser
    uefitool
    uefitoolPackages.new-engine
    uefitoolPackages.old-engine
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    efitools
] else [
   # pkgs-x86_64.efitools
])

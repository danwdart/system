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
    efivar
    sbctl
    sbsigntool
    uefitool
    uefitoolPackages.new-engine
    uefitoolPackages.old-engine
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    # efitools # won't build
] else [
   # pkgs-x86_64.efitools
])

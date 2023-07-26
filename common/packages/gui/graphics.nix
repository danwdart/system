pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs; [
    # blender # fails to build
    # geogebra
    gimp
    inkscape
    krita
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    dia
] else [
    pkgs-x86_64.dia
])

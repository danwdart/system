pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
    pkgsGimpRC = import (builtins.fetchTarball
        "https://github.com/jtojnar/nixpkgs/archive/refs/heads/gimp-meson.zip"
    ) {};
in
with pkgs; [
    # blender # fails to build because of python3.11-openusd
    geogebra
    pkgsGimpRC.gimp
    inkscape
    krita
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    dia
] else [
   # pkgs-x86_64.dia
])

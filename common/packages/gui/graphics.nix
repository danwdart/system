pkgs:
with pkgs; [
    # blender # fails to build
    # geogebra
    gimp
    inkscape
    krita
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    dia
] else [
])

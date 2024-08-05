pkgs:
let pkgs-x86_64 = import <nixos> {
        system = "x86_64-linux";
        config = {
            allowUnfree = true;
        };
    };
in
with pkgs;
if builtins.currentSystem == "x86_64-linux" then [
    # google-chrome
] else [
   # pkgs-x86_64.google-chrome
]

pkgs:
with pkgs; [
    firefox
] ++ (if builtins.currentSystem == "x86_64-linux" then [
    google-chrome
] else [
])

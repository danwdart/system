{ pkgs, unstable, ... }:
with pkgs; [
    cool-retro-term
    unstable.androidStudioPackages.canary
    unstable.android-tools
    kate
    unstable.vscode # insiders?
    x11docker
]
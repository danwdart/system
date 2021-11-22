{ pkgs, unstable, ... }:
with pkgs; [
    kate
    unstable.vscode # insiders?
    x11docker
]
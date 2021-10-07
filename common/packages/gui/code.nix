{ pkgs, unstable, ... }:
with pkgs; [
    unstable.vscode # insiders?
    x11docker
]
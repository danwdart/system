{ pkgs, ... }:
with pkgs; [
    # androidStudioPackages.canary # bwrap: Can't find source path /System: No such file or directory, see https://github.com/NixOS/nixpkgs/issues/112045
    code-server
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    postman
    vim
    vscode # insiders?
    x11docker
    xcodebuild
]
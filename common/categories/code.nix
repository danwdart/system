{ pkgs, ... }:
with pkgs; [
    android-studio
    code-server
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    vim
    vscode # insiders?
    x11docker
    xcodebuild
]
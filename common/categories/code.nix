{ pkgs, ... }:
let
    unstable = import <unstable> {
        config = {
            allowUnfree = true;
        };
    };
in with pkgs; [
    androidStudioPackages.canary
    code-server
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    vim
    unstable.vscode # insiders?
    x11docker
    xcodebuild
]
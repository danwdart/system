{ pkgs, unstable, ... }:
with pkgs; [
    # androidStudioPackages.canary # platform-tools? fastboot?
    # code-server # unneeded
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    vim
    # xcodebuild
]
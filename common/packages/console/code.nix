{ pkgs, unstable, ... }:
with pkgs; [
    # platform-tools?
    adbfs-rootless
    python39Packages.android-backup
    code-server # unneeded
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    shellinabox
    vim # plugins?
    # xcodebuild
]
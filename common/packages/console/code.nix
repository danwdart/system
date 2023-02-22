pkgs:
with pkgs; [
    # platform-tools?
    adbfs-rootless
    # python312Packages.android-backup # build failure
    # code-server # unneeded
    docker-compose
    gitAndTools.gh
    gitAndTools.gitFull
    gitAndTools.git-hub
    gitAndTools.hub
    git-crypt
    git-lfs
    vim # plugins?
    # xcodebuild
]
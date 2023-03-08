pkgs:
with pkgs; [
    # platform-tools?
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
] ++ (if builtins.currentSystem != "aarch64-linux" then [
    adbfs-rootless
] else [

])

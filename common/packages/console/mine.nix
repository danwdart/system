pkgs:
let haskellRepo = /home/dwd/code/mine/haskell;
    chatter = import "${haskellRepo}/dubloons/default.nix" {};
    dubloons = import "${haskellRepo}/dubloons/default.nix" {};
    jobfinder-server = import "${haskellRepo}/jobfinder/api.nix" {};
in [
    chatter
    dubloons
    jobfinder-server
]
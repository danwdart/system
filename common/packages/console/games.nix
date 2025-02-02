pkgs:
with pkgs; [
    # bsdgames # will no longer compile - https://github.com/vattam/BSDGames/issues/15
    # TODO bring back from master - fixed in https://github.com/NixOS/nixpkgs/issues/369248
    nethack
    pfsshell
]

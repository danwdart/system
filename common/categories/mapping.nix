{ pkgs, ... }:
let
    unstable = import <unstable> {
        config = {
            allowUnfree = true;
        };
    };
in with unstable; [
    googleearth
]
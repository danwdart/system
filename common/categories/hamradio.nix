{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    chirp
    direwolf
    fldigi
    qsstv
    unstable.soundmodem
    wsjtx
]
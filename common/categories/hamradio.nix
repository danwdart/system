{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    chirp
    direwolf
    fldigi
    gpredict
    qsstv
    unstable.soundmodem
    wsjtx
]
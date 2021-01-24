{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    chirp
    direwolf
    fldigi
    gpredict
    minimodem
    qsstv
    unstable.soundmodem
    wsjtx
]
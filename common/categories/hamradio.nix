{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    chirp
    fldigi
    qsstv
    unstable.soundmodem
    wsjtx
]
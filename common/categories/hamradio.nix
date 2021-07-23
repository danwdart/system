{ pkgs, ... }:
let
    unstable = import <unstable> {};
in with pkgs; [
    chirp
    direwolf
    fldigi
    gpredict
    minimodem
    multimon-ng
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
]
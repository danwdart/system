{ pkgs, unstable, ... }:
with pkgs; [
    chirp
    # direwolf # compilation issues?
    fldigi
    flrig
    gpredict
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
]

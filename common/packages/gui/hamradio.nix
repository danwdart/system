{ pkgs, unstable, ... }:
with pkgs; [
    chirp
    cqrlog
    # direwolf # compilation issues?
    fldigi
    flrig
    gpredict
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
    xlog
]

{ pkgs, unstable, master, ... }:
with pkgs; [
    chirp
    cqrlog
    # direwolf # compilation issues?
    fldigi
    flrig
    master.freedv
    gpredict
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
    xlog
]

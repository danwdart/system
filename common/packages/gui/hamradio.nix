{ pkgs, unstable, master, ... }:
with master; [
    chirp
    cqrlog
    # direwolf # compilation issues?
    fldigi
    flrig
    freedv
    gpredict
    qsstv
    tqsl
    soundmodem # no desktop icon, needs config
    wsjtx
    xlog
]

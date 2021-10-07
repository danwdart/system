{ pkgs, unstable, ... }:
with pkgs; [
    chirp
    # direwolf # compilation issues?
    fldigi
    gpredict
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
]

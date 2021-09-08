{ pkgs, unstable, ... }:
with pkgs; [
    chirp
    # direwolf # compilation issues?
    fldigi
    gpredict
    minimodem
    multimon-ng
    qsstv
    unstable.soundmodem # no desktop icon, needs config
    wsjtx
]

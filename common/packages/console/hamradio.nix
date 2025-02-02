pkgs:
with pkgs; [
    # ax25-apps # failed to compile - https://github.com/NixOS/nixpkgs/issues/370906
    ax25-tools
    cqrlog
    hamlib
    minimodem
    multimon-ng
]

{ pkgs, ... }:
with pkgs; [
    bind # host, nslookup etc
    doctl # run doctl auth init before use
    irssi
    mailutils
]
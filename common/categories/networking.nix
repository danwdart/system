{ pkgs, ... }:
with pkgs; [
    bind # host, nslookup etc
    doctl # run doctl auth init before use
    irssi
    mailutils
    nextcloud-client
    putty # no desktop icon
    rdesktop # no gui without config
    scrcpy
    tightvnc # no gui without config
    # tor-browser-bundle-bin # 404?
]
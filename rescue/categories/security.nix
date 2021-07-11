{ pkgs, ... }:
with pkgs; [
    aircrack-ng
    chkrootkit
    john
    thc-hydra
    lynis
    nmap
    openssl # the CLI client
    # ossec - not yet integrated into systemd
    # pam_usb - already an option
    pyrit
    # rkhunter - not yet available
    # tripwire - not yet available - unsure if any point?
]

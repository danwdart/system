{ pkgs, ... }:
with pkgs; [
    aircrack-ng
    binwalk
    chkrootkit
    hexedit
    john
    lynis
    masscan
    metasploit
    nmap
    openssl # the CLI client
    # ossec - not yet integrated into systemd
    # pam_usb - already an option
    pyrit
    # rkhunter - not yet available
    tcpdump
    thc-hydra
    # tripwire - not yet available - unsure if any point?
]
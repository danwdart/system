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
    pyrit
    # rkhunter - not yet available
    sshuttle
    tcpdump
    thc-hydra
    # tripwire - not yet available - unsure if any point?
]
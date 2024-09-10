pkgs:
with pkgs; [
    aircrack-ng
    binwalk # python issues
    chkrootkit
    gpgme
    hexedit
    john
    lynis
    masscan
    metasploit # failed
    nmap
    openssl # the CLI client
    # ossec-agent - not yet integrated into systemd
    # ossec-server - not yet integrated into systemd
    sslstrip
    # rkhunter - not yet available
    sshuttle
    tcpdump
    thc-hydra
    # tripwire - not yet available - unsure if any point?
]
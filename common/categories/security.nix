{ pkgs, ... }:
with pkgs; [
    chkrootkit
    lynis
    metasploit
    nmap
    ossec
    # rkhunter
    # tripwire
]
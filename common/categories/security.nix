{ pkgs, ... }:
with pkgs; [
    chkrootkit
    lynis
    metasploit
    nmap
    ossec
    pam_usb
    # rkhunter
    # tripwire
]
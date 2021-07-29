{...}:
{
  # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  nameservers = [
    # if using DoH/DoT proxy
    # "127.0.0.1" "::1"
    # opennic, giving http://grep.geek etc
    # "194.36.144.87" "94.247.43.254" "2a03:4000:4d:c92:88c0:96ff:fec6:b9d" "2a00:f826:8:1::254"
    # also opennic
    # "95.217.229.211" "165.22.224.164" "2a01:4f9:4b:39ea::301" "2604:a880:cad:d0::d9a:f001"
    # adguard
    "94.140.14.14" "94.140.15.15" "2a10:50c0::ad1:ff" "2a10:50c0::ad2:ff"
    # quad9
    # "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9"
  ];

  # resolvconf.enable = false;

  networkmanager = {
    enable = true;
    # packages = 
#    dns = "
    #insertNameservers = [
    # extra stuff only
    #];
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  useDHCP = false;
  # interfaces.enp0s3.useDHCP = true;

  # proxy.default = "http://user:password@proxy:port/";
  # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  firewall.allowedTCPPorts = [ 22 80 443 ];
  # firewall.allowedUDPPorts = [];
  # firewall.allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  # firewall.allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];

  firewall.pingLimit = "--limit 1/minute --limit-burst 5";
  firewall.checkReversePath = true;

  # KDE Connect, PulseAudio and Samba - only from LANs
  firewall.extraCommands = ''
    iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 1714:1764 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --source 192.168.1.0/24 -m multiport --dports 139,445 -j nixos-fw-accept
    iptables -A nixos-fw -p tcp --source 192.168.1.0/24 --dport 4713 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.1.0/24 --dport 1714:1764 -j nixos-fw-accept
    iptables -A nixos-fw -p udp --source 192.168.1.0/24 -m multiport --dports 137,138 -j nixos-fw-accept
  '';

  extraHosts = ''
    192.168.15.18  api.timetrack.local
    192.168.15.18  mail.timetrack.local
    192.168.28.2   wordpress.timetrack.local
    127.0.0.1      fafnir.dandart.co.uk
  '';

  # Or disable the firewall altogether.
  # firewall.enable = false;
}
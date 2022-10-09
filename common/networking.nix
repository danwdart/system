{ lib, hostName, ... }:
with builtins;
with lib;
let
  telnetServers = import ./servers/telnet.nix;
  allowTelnet = ip: "iptables-nft -A OUTPUT -p tcp --dport 23 -d ${ip} -j ACCEPT";
in {
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

  firewall = {
    # Or disable the firewall altogether.
    # enable = false;
    enable = true;
    # allowedTCPPorts = [ 22 80 443 ];
    # allowedUDPPorts = [];
    # allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    # allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];

    pingLimit = "--limit 1/minute --limit-burst 5";
    checkReversePath = true;
    logReversePathDrops = true;
    logRefusedConnections = true;
    # TODO to nftables
    extraCommands = builtins.readFile "/home/dwd/code/mine/nix/system/common/conf/iptables.sh" +
      (lib.strings.concatStringsSep "\n" (map allowTelnet (attrValues telnetServers)));
    # Allow private IP ranges
    # extraCommands = ''
    # '';
    # iptables-nft -A INPUT -p tcp -s 10.0.0.0/8 -j ACCEPT
    # iptables-nft -A INPUT -p tcp -s 172.16.0.0/12 -j ACCEPT
    # iptables-nft -A INPUT -p tcp -s 192.168.0.0/16 -j ACCEPT
  };

  extraHosts = ''
    127.0.0.1      ${hostName}.dandart.co.uk home.dandart.co.uk grocy.dandart.co.uk nextcloud.dandart.co.uk roqqett.dandart.co.uk roq-wp.dandart.co.uk dev.dandart.co.uk dev.jolharg.com news.jolharg.com dev.madhackerreviews.com dev.m0ori.com dev.blog.dandart.co.uk jobfinder.jolharg.com api.jobfinder.jolharg.com
  '';
}
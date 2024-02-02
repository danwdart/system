# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
let hostName = "zhang";
in
{
    _module.args.hostName = hostName;
    _module.args.internalIPv4 = "10.0.0.168";
    _module.args.externalIPv4 = "143.47.240.248";
    _module.args.localIPv6 = "fe80::a8d3:9bea:23ae:3135";
    _module.args.globalIPv6 = "2603:c020:c005:7c00:4b99:973c:65d2:5837";
    _module.args.fqdn = "zhang.jolharg.com";
    imports = [
        ./hardware-configuration.nix
        ../common/configuration-server.nix
    ];

    networking.hostName = hostName;

    services.openssh.banner = "Connection established to ${hostName}. Unauthorised connections are logged.\n";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}

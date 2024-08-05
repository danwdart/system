# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
let hostName = "scorpii";
    impermanence = builtins.fetchTarball {
      url =
        "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    };
in
{
    _module.args.hostName = hostName;
    _module.args.internalIPv4 = "192.168.1.73";
    _module.args.externalIPv4 = "141.195.161.125";
    _module.args.localIPv6 = "fe80::7a59:8b85:d40b:2bfb";
    _module.args.globalIPv6 = "2a0a:5586:cdd::7";
    _module.args.fqdn = "scorpii.dandart.co.uk";
    imports = [
        "${impermanence}/nixos.nix"
        ./hardware-configuration.nix
        ../common/configuration-desktop.nix
    ];

    networking.hostName = hostName;
    networking.domain = "dandart.co.uk";

    services.openssh.banner = "Connection established to ${hostName}. Unauthorised connections are logged.\n";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}

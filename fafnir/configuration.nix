# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let impermanence = builtins.fetchTarball {
      url =
        "https://github.com/nix-community/impermanence/archive/master.tar.gz";
    };
    hostName = "fafnir";
in {

    _module.args.hostName = hostName;
    imports = [
        "${impermanence}/nixos.nix"
        ./hardware-configuration.nix
        ../common/configuration-desktop.nix
    ];

    networking.hostName = hostName;

    services.openssh.banner = "Connection established to ${hostName}. Unauthorised connections are logged.\n";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "20.09"; # Did you read the comment?
}

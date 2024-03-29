
{ pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];
    nixpkgs.config.allowUnfree = true;
    boot.tmp.cleanOnBoot = true;
    zramSwap.enable = true;
    networking.hostName = "zhang";
    networking.domain = "jolharg.com";
    environment.systemPackages = import ../common/packages/console/packages.nix pkgs;
    services.openssh.enable = true;
    programs.nix-ld = {
        enable = true; # breaks ls in nix shells!?
        # Sets up all the libraries to load
        libraries = with pkgs; [
            stdenv.cc.cc
            zlib
            fuse3
            icu
            zlib
            nss
            openssl
            curl
            expat
        ];
    };
    users = import ../common/users.nix { privateDir = "/home/dwd/code/mine/nix/system/zhang/private"; }; 
    system.stateVersion = "23.05";
}


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
    services.openvscode-server.enable = true;
    users = import ../common/users.nix { privateDir = "/home/dwd/code/mine/nix/system/zhang/private"; }; 
    system.stateVersion = "23.05";
}

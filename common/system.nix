{ hostName, ... }:
{
    autoUpgrade = {
      enable = true;
      persistent = true; 
      dates = "hourly";
      allowReboot = true; # okay this is getting annoying, disabled until NixOS supports kexec/ksplice/etc
      rebootWindow = {
          lower = "19:00";
          upper = "07:00";
      };
      flags = [
          "-I"
          "nixos-config=/home/dwd/code/mine/nix/system/${hostName}/configuration.nix"
      ];
  };
}

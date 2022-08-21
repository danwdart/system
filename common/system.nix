{ hostName, ... }:
{
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      #rebootWindow = {
      #    lower = "19:00";
      #    upper = "07:00";
      #};
      flags = [
          "-I"
          "nixos-config=/home/dwd/code/mine/nix/system/${hostName}/configuration.nix"
      ];
  };
}
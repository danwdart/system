{ pkgs, unstable, ... }:
{
  pulseaudio = {
    enable = false;
    /*
    extraModules = with pkgs; [
      pulseaudio-modules-bt
    ];
    package = pkgs.pulseaudioFull;
    tcp = {
      enable = true;
      anonymousClients = {
        allowedIpRanges = [
          "127.0.0.1"
          "192.168.1.0/24"
        ];
      };
    };
    support32Bit = true;
    zeroconf = {
      discovery = {
        enable = true;
      };
      publish = {
        enable = true;
      };
    };
    */
  };

  opengl.driSupport = true;
  opengl.driSupport32Bit = true;
  opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva unstable.pkgsi686Linux.amdvlk ];
  opengl.extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];

  bluetooth.enable = true;
  bluetooth.powerOnBoot = true;
  bluetooth.package = pkgs.bluezFull;
}
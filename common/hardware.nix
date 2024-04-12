{ pkgs, isDesktop, ...}:
{
  cpu.intel.updateMicrocode = builtins.currentSystem == "x86_64-linux";

  pulseaudio.enable = false;

  opengl = if isDesktop then {
    driSupport = true;
    driSupport32Bit = builtins.currentSystem == "x86_64-linux";
    #extraPackages32 = with pkgs.pkgsi686Linux; [ libva pkgsi686Linux.amdvlk ];
    #extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
  } else {};

  bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };

  hackrf.enable = true;

  # sane = if isDesktop then {
  #   enable = true;
  #   extraBackends = with pkgs; [
  #     hplipWithPlugin
  #   ];
  # } else {};
}

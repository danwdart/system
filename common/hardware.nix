pkgs:
{
  cpu.intel.updateMicrocode = true;

  pulseaudio.enable = false;

  opengl = {
    driSupport = true;
    driSupport32Bit = true;
    #extraPackages32 = with pkgs.pkgsi686Linux; [ libva pkgsi686Linux.amdvlk ];
    #extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
  };

  bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluezFull;
  };

  hackrf.enable = true;
}
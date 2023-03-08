pkgs:
{
  cpu.intel.updateMicrocode = if builtins.currentSystem == "x86_64-linux" then true else false;

  pulseaudio.enable = false;

  opengl = {
    driSupport = true;
    driSupport32Bit = if builtins.currentSystem == "x86_64-linux" then true else false;
    #extraPackages32 = with pkgs.pkgsi686Linux; [ libva pkgsi686Linux.amdvlk ];
    #extraPackages = with pkgs; [ amdvlk rocm-opencl-icd rocm-opencl-runtime ];
  };

  bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };

  hackrf.enable = true;

  sane = {
    enable = true;
    extraBackends = with pkgs; [
      hplipWithPlugin
    ];
  };
}

{ pkgs, isDesktop, ...}:
{
  cpu.intel.updateMicrocode = builtins.currentSystem == "x86_64-linux";

  pulseaudio.enable = false;

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

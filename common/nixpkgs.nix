{...}:
{
  config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # ???
      "python2.7-pyjwt-1.7.1"
    ];
    packageOverrides = pkgs: {
      xsaneGimp = pkgs.xsane.override { gimpSupport = true; };
      # ln -s /run/current-system/sw/bin/xsane ~/.config/GIMP/2.10/plug-ins/xsane
    };
  };
}
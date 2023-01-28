{ privateDir, ...}:
{
  # Don't allow mutation of users outside of the config.
  mutableUsers = false;

  # Set a root password, consider using
  # initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.root.initialHashedPassword = builtins.readFile "${privateDir}/users/root/hashed_password";

  users.dwd = {
    createHome = true;
    description = "Dan Dart";
    initialHashedPassword = builtins.readFile "${privateDir}/users/dwd/hashed_password";
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "dialout"
      "docker"
      "jackaudio"
      "kvm"
      "libvirtd"
      "lp"
      "networkmanager"
      "plugdev"
      "scanner"
      "vboxusers"
      "wheel"
      "wireshark"
    ];
  };

  users.raven = {
    createHome = true;
    description = "Raven Bloodmoon";
    initialHashedPassword = builtins.readFile "${privateDir}/users/raven/hashed_password";
    isNormalUser = true;
    extraGroups = [
      "dialout"
      "jackaudio"
      "lp"
      "networkmanager"
      "plugdev"
      "scanner"
    ];
  };
}
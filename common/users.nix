{...}:
{
  # Don't allow mutation of users outside of the config.
  mutableUsers = false;

  # Set a root password, consider using
  # initialHashedPassword instead.
  #
  # To generate a hash to put in initialHashedPassword
  # you can do this:
  # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
  users.root.initialHashedPassword = "$6$8RZ1PPxKU6h$dNHnIWiq.h8s.7SpMW14FzK9bJwg1f6Mt.972/2Fij4zPrhR0X4m3JTNPtGAyeMKZk3I8x/Xro.vJolwVvwd9.";

  users.dwd = {
    createHome = true;
    description = "Dan Dart";
    initialHashedPassword = "$6$EDn9CboEV/$ESAQifZD0wiVkYf1MuyLqs.hP7mvelpoPnSGEI7CmwuUifi090PT6FQqHsdhlZSXSlqrT9EH.mIfUvxPCA5q.1";
    isNormalUser = true;
    extraGroups = [
      "adbusers"
      "dialout"
      "docker"
      "jackaudio"
      "kvm"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "vboxusers"
      "wheel"
      "wireshark"
    ];
  };
}
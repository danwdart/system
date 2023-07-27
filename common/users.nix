{ privateDir, ...}:
let dansKeys = [
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6DDaMcQMcPI5DMU2pgaxTcd83E/xoHnJFXwSIkjkSZPpfhRBOorcXnhi2qs6PzYcKkC/50vm9+kEnZDERNr/HmSwEZt83UpzA4AmAjhDuFzCumyv7m8XjlL4dFxPLYgSmHTAzk54AtbiZfWRH6dgXE0SHF9Oyk8o3QYp4G3/KQ11DsVG1LbRYUWkdfWLQ1A+/oRh3HaBAX/p7fMKJqDayMtYxDxtMVqVu5oPpWsadboC7z9IbfF+DQCqTgjwW/+u9CD62ceiDUesO2Uwg2PzW6rydtpQU3eYIMePRQIPI79doRxZFiyxLlzgVMRGFiB1RYkdw49jei1envwFGB2uiBNeFnyP2EMvCGBIX0rcyoDKyEixhMito8dyYUO2I62F7+dkOOnq2ofTn/n9wLCM+oRtxyNEwT++eUt4G1ZBmWEdBYLsa/wXC3Q78OoPEt4ECmP+NvaFHpllRWL+jKXtmGrOcK0T+KPf6C4i0kwSm++uTjR8ZKR/D5vsfiRawR08= nix-on-droid@localhost''
    ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDYdqN0shqtDIWOauiAead09dF0Qmjd9IZnfRsHeLSGDTqLfxRhkJGMOdHAH8Bp9XZzvjIrG8e9Tc7y0x2lz1nC6kcqZCRhEphc8IpuOjAT/RVx8rvQKnid9zBrMgVKOKeRRUwqyUnYakFSreSaJM/ttWFkjU3re99fL/8bY0u5bOZlE2YLaGp144Rqvk5S/REklGICUt3ZZFkFjIh0rg0VaRYeXNFokxSLVuJJpiJ6RgRB0vw2ZMOg3hitv4EEeBdNQqG1RKfRKeaaIj1VFxzqZM7VyAW8O8BdWRSwlnhtMNqpFVbB6+WrR5/e8hOpR9IlAb4HczfRK0bDSuy9e9yvVQ2twVle4buzkq1HOtOF5DbXLY/cHBr3PWAoweimBYhd2o93nQz7qEedm1+rL5Z4JE6u1U7AMhAcDWSoJGsQZwSeICDlIsLHLXJ3HRZQ6H3MqwLFu9x35I7OyLac0kTAqsh9m+4Vi6ha/JlyYlSBE9Jlg9Vx2BPNcNHsHEcAAfc= dwd@M-H7MN7QR4V5''
];
in
{
    # Don't allow mutation of users outside of the config.
    mutableUsers = false;
  
    # Set a root password, consider using
    # initialHashedPassword instead.
    #
    # To generate a hash to put in initialHashedPassword
    # you can do this:
    # $ nix-shell --run 'mkpasswd -m SHA-512 -s' -p mkpasswd
    users.root = {
        initialHashedPassword = builtins.readFile "${privateDir}/users/root/hashed_password";
        openssh.authorizedKeys.keys = dansKeys;
    };  
  
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
        openssh.authorizedKeys.keys = dansKeys;
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

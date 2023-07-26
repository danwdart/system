{...}:
{
  services = {
    nginx = {
      serviceConfig = {
        # allow nginx to read /home as that's where I stashed my code (don't do this in prod)
        ProtectHome = "read-only";
      };
    };
  };

  tmpfiles.rules = [
  # only on big evil desktop
  #  "w /sys/devices/system/cpu/cpufreq/boost - - - - 0"

    # for nginx
    "z /home/dwd 0755 dwd users - -"
    "d /var/lib/clamav 0755 clamav clamav" # because clamav doesn't do this for us?
    # TODO do a wget / curl to get the latest files, or run freshclam
  ];

  #services = {
  #  jobfinder-api = {
  #    description = "JobFinder API";
  #    after = ["network.target"];
  #    serviceConfig = {
  #      ExecStart = "/home/dwd/code/mine/haskell/jobfinder/result/backend/bin/backend";
  #      WorkingDirectory = "/home/dwd/code/mine/haskell/jobfinder/app/backend";
  #      Type = "simple";
  #      # LoadCredential
  #      # StateDirectory =
  #      DynamicUser = true;
  #      RestrictNamespaces = true;
  #      SystemCallArchitectures = "native";
  #      PrivateUsers = true;
  #      ProtectHostname = true;
  #      ProtectClock = true;
  #      ProtectKernelTunables = true;
  #      ProtectKernelModules = true;
  #      ProtectKernelLogs = true;
  #      ProtectControlGroups = true;
  #      RestrictAddressFamilies = ["AF_UNIX AF_INET AF_INET6"];
  #      LockPersonality = true;
  #      RestrictRealtime = true;
  #      SystemCallFilter =
  #        "~"
  #        + (builtins.concatStringsSep " " [
  #          "@clock"
  #          "@cpu-emulation"
  #          "@debug"
  #          "@keyring"
  #          "@memlock"
  #          "@module"
  #          "@mount"
  #          "@obsolete"
  #          "@raw-io"
  #          "@reboot"
  #          "@resources"
  #          "@setuid"
  #          "@swap"
  #        ]);
  #      RemoveIPC = true;
  #      PrivateTmp = true;
  #      PrivateDevices = true;
  #      NoNewPrivileges = true;
  #      RestrictSUIDSGID = true;
  #      ProtectSystem = "strict";
  #      ProtectHome = "read-only"; # "tmpfs"
  #    };
  #  };
  #};
}
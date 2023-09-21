{ isDesktop, ... }:
{
  services = if isDesktop then {} else {
    nginx = {
      serviceConfig = {
        # allow nginx to read /home as that's where I stashed my code (don't do this in prod)
        ProtectHome = "read-only";
      };
    };
    # @TODO build this
    jobfinder-api = {
      enable = true;
      description = "JobFinder API";
      after = ["multi-user.target"];
      script = ''
        /run/wrappers/bin/su - dwd -c '
          set -a; \
          cd /home/dwd/code/mine/haskell/jobfinder/src/api; \
          source /home/dwd/code/mine/haskell/jobfinder/.env; \
          ../../result/api/bin/api'
      '';
    };

    dubloons = {
      enable = true;
      description = "Arrr, dubloons!";
      after = ["multi-user.target"];
      script = ''
        /run/wrappers/bin/su - dwd -c '
          set -a; \
          cd /home/dwd/code/mine/haskell/dubloons; \
          source /home/dwd/code/mine/haskell/dubloons/.env; \
          ./result/bin/dubloons'
      '';
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
}
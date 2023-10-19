{ isDesktop, privateDir, ... }:
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

    postgrest = let
      appBuilderPassword = builtins.readFile "${privateDir}/app-builder/dbpass";
    in
    {
      enable = true;
      description = "PostgREST";
      environment = {
        PGRST_DB_URI = "postgres://authenticator:${appBuilderPassword}@localhost:5432/app_builder";
        PGRST_DB_SCHEMAS = "app_builder";
        PGRST_DB_ANON_ROLE = "web_anon";
      };
      after = ["multi-user.target"];
      script = "/run/current-system/sw/bin/postgrest";
      reload = "/run/current-system/sw/bin/pkill -SIGUSR2 postgrest";
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
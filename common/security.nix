{pkgs, ...}:
{
  acme = {
    defaults = {
      email = "acme@dandart.co.uk";
      group = "nginx";
      webroot = "/var/lib/acme/acme-challenge";
    };
    acceptTerms = true;
    #certs = {
    #  "home.dandart.co.uk" = {
    #    extraDomainNames = [
    #      "nextcloud.dandart.co.uk"
    #      "news.jolharg.com"
    #      "roqqett.dandart.co.uk"
    #      "roq-wp.dandart.co.uk"
    #      "dev.dandart.co.uk"
    #      "dev.jolharg.com"
    #      "dev.blog.jolharg.com"
    #      "dev.madhackerreviews.com"
    #      "dev.m0ori.com"
    #      "dev.blog.dandart.co.uk"
    #      "dev.jobfinder.jolharg.com"
    #      "jobfinder.jolharg.com"
    #      "api.jobfinder.jolharg.com"
    #      "grocy.dandart.co.uk"
    #    ];
    #  };
    #};
  };

  # pam.usb.enable = true;
  # TODO pam phone fingerprint?

  rtkit.enable = true;

  # when persist use persist here

  # We no longer need these but I'll just leave this here so we know how to do it

  #pki.certificateFiles = [
  #  "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
  #  # ../common/private/ca-bundle.crt
  #  /home/dwd/code/mine/nix/system/common/private/rootCA.pem
  #  /home/dwd/code/mine/nix/system/common/private/local-cert.pem
  #];
}
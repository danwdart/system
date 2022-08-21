{pkgs, ...}:
{
  acme.defaults.email = "acme@dandart.co.uk";
  acme.acceptTerms = true;

  # pam.usb.enable = true;
  # TODO pam phone fingerprint?

  rtkit.enable = true;

  pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    # ../common/private/ca-bundle.crt
    /home/dwd/code/mine/nix/system/common/private/rootCA.pem
    /home/dwd/code/mine/nix/system/common/private/local-cert.pem
  ];
}
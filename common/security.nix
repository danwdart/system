{pkgs, ...}:
{
  acme.email = "acme@dandart.co.uk";
  acme.acceptTerms = true;

  # pam.usb.enable = true;
  # TODO pam phone fingerprint?

  pki.certificateFiles = [
    "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
    # ../common/private/ca-bundle.crt
    /persist/home/dwd/code/mine/nix/system/common/private/rootCA.pem
    /persist/home/dwd/code/mine/nix/system/common/private/local-cert.pem
  ];
}
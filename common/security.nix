{ pkgs, isDesktop, hostName, ... }:
{
  acme = {
    defaults = {
      email = "acme@dandart.co.uk";
      group = "nginx";
      webroot = "/var/lib/acme/acme-challenge";
    };
    acceptTerms = true;
    certs = {
      "${hostName}.${if isDesktop then "home." else ""}dandart.co.uk" = {
        extraDomainNames = [
          # these need to be real and pointing here, they can't be "just in case"
          # "nextcloud.dandart.co.uk"
          # "roqqett.dandart.co.uk"
          # "roqqett.home.dandart.co.uk"
          # "roq-wp.dandart.co.uk"
          "dev.dandart.co.uk"
          "dev.jolharg.com"
          "dev.blog.jolharg.com"
          "dev.madhackerreviews.com"
          "dev.m0ori.com"
          "dev.blog.m0ori.com"
          "dev.blog.dandart.co.uk"
          "dev.jobfinder.jolharg.com"
          "api.dev.jobfinder.jolharg.com"
          "jobfinder.jolharg.com"
          "api.jobfinder.jolharg.com"
          "news.dandart.co.uk"
          # "grocy.dandart.co.uk"
        ];
      };
      "dandart.geek" = {
        server = "https://playground.acme.libre";
      };
    };
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

  pki.certificateFiles = [
    # OpenNIC
    # TODO script to download without SSL
    # TODO verify
    (pkgs.writeText "opennic_root_ca.crt" ''
      Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number: 26 (0x1a)
            Signature Algorithm: sha256WithRSAEncryption
            Issuer: DC=libre, DC=acme, DC=playground, O=OpenNIC, OU=OpenNIC CA, CN=OpenNIC Root CA
            Validity
                Not Before: Feb  1 20:08:33 2024 GMT
                Not After : Aug  1 20:08:33 2024 GMT
            Subject: DC=libre, DC=acme, DC=playground, O=OpenNIC, OU=OpenNIC CA, CN=OpenNIC Root CA
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    Public-Key: (4096 bit)
                    Modulus:
                        00:aa:0e:d0:3b:e6:08:ec:91:c5:d9:66:21:44:0b:
                        33:a0:f4:9b:99:f7:a0:5b:a5:f4:12:a1:85:dc:4c:
                        97:63:ee:02:07:d2:62:c6:44:f4:19:c6:68:c7:1f:
                        a2:f1:54:a1:76:d0:a7:42:8d:b1:27:42:fe:15:04:
                        48:e0:38:6d:d3:16:61:7d:21:07:f5:16:a1:9e:5e:
                        08:55:15:83:46:46:1d:b9:5b:d7:68:65:91:c6:44:
                        35:51:f9:40:26:e4:9b:89:b4:b8:8c:e7:bf:b7:60:
                        eb:b9:aa:23:e5:58:2a:45:1c:6c:b9:a9:30:fe:f0:
                        47:a5:10:4c:5c:86:58:bf:64:d2:29:e4:8d:e4:46:
                        85:c6:b6:03:27:2b:44:b1:e0:1c:6b:81:3d:2f:1b:
                        91:4e:40:1b:6b:8a:5d:1e:cb:4e:a8:be:dd:09:4b:
                        fb:23:d5:ff:d0:c9:1f:d4:08:69:3e:10:f7:99:62:
                        d3:ef:0c:aa:92:e9:62:97:c5:ff:79:38:3f:92:f4:
                        f6:4c:b0:0d:fb:82:9e:ba:cb:be:39:19:e4:9b:df:
                        82:de:63:55:25:a1:9a:28:ea:7f:37:2b:18:af:31:
                        46:b3:69:07:50:e3:10:6e:d3:7a:c1:77:65:bd:57:
                        7e:29:85:3c:30:f1:c6:f9:16:62:8d:b4:48:cb:e8:
                        76:1b:bb:ff:2b:ac:6a:5d:6f:b4:bb:95:62:87:19:
                        db:ad:91:b9:f0:98:df:4e:12:2f:ab:e2:10:94:4b:
                        1a:1a:4b:f8:46:66:1b:59:15:bc:38:3e:32:c3:7f:
                        c6:4c:e8:f5:d5:7f:60:69:f5:70:5b:12:14:70:50:
                        e8:f7:70:f2:7e:b4:1b:1d:3e:09:a6:07:34:36:5f:
                        54:78:86:13:dc:02:53:3c:fd:14:5d:ca:f5:96:6a:
                        5f:6e:bd:0f:db:d4:10:64:d4:36:b3:55:6a:f8:f6:
                        e4:f2:c0:84:50:ba:2f:5b:a0:11:0f:6a:ba:05:29:
                        e0:a2:53:ec:98:3a:7b:12:b4:30:72:b5:d8:5f:e8:
                        6c:b3:d8:0b:a9:46:7d:c8:63:7a:fa:c3:55:49:89:
                        9c:70:40:fa:8a:2f:2b:7d:4d:bd:7c:73:7b:39:ee:
                        26:8a:48:a0:3c:ff:0a:0a:fc:c0:d4:00:5f:ad:2a:
                        71:9e:a3:72:78:ef:f8:37:d1:05:77:a8:e5:b6:bb:
                        c8:67:82:91:41:2c:d5:e0:65:e6:5d:7c:7f:ee:f3:
                        99:ef:10:ce:9a:64:2a:69:a1:80:55:09:64:39:90:
                        5a:5b:6a:74:3d:76:32:53:20:cc:a5:cf:75:a4:ea:
                        c6:8f:bb:ab:04:88:2e:a4:aa:52:0b:90:47:37:e7:
                        bc:11:75
                    Exponent: 65537 (0x10001)
            X509v3 extensions:
                X509v3 Key Usage: critical
                    Digital Signature, Certificate Sign, CRL Sign
                X509v3 Basic Constraints: critical
                    CA:TRUE, pathlen:1
                X509v3 Subject Key Identifier: 
                    A1:10:8C:9B:F4:59:3B:2F:F4:8A:B2:19:02:8F:82:94:E7:CC:6B:93
                X509v3 Authority Key Identifier: 
                    A1:10:8C:9B:F4:59:3B:2F:F4:8A:B2:19:02:8F:82:94:E7:CC:6B:93
                X509v3 Name Constraints: critical
                    Permitted:
                      DNS:.bbs
                      DNS:.chan
                      DNS:.cyb
                      DNS:.dyn
                      DNS:.geek
                      DNS:.gopher
                      DNS:.indy
                      DNS:.libre
                      DNS:.neo
                      DNS:.null
                      DNS:.o
                      DNS:.oss
                      DNS:.oz
                      DNS:.parody
                      DNS:.pirate
        Signature Algorithm: sha256WithRSAEncryption
        Signature Value:
            8e:a5:67:48:44:7e:70:8b:8e:18:bd:5b:73:71:5f:62:97:9f:
            89:7f:56:f2:46:b0:c9:d8:d9:4d:94:27:56:fc:2e:19:2b:b9:
            e4:1b:c1:a1:4a:68:a6:49:2c:06:b8:74:56:87:65:6a:90:84:
            83:ab:3d:c2:c4:4a:b8:35:fc:c4:14:96:93:23:78:bb:af:6a:
            2f:ad:54:33:53:36:c7:71:de:d7:28:ad:f6:c0:6f:57:72:03:
            27:83:1b:77:47:4e:10:14:a2:f8:5f:58:50:1b:be:01:f9:34:
            c5:77:b6:f0:60:c0:ea:2b:64:4f:08:ff:da:f3:ac:a2:3b:c8:
            b8:d8:78:a8:e8:be:59:23:b3:74:d6:00:14:f0:d5:95:93:4e:
            f6:6f:bb:60:c0:a5:85:51:4f:51:3d:45:02:1b:8b:84:74:78:
            77:fa:43:52:13:f2:60:78:82:62:41:18:ce:9c:28:ba:d8:ed:
            51:bd:d6:54:e3:a0:04:00:44:2b:dc:49:75:f3:d8:0b:29:52:
            f1:28:31:d9:e0:79:eb:83:89:28:2c:06:da:6b:de:3f:65:85:
            07:28:59:b3:1e:7f:1e:47:39:8a:9a:76:37:09:f8:09:28:0f:
            d0:05:22:ac:38:b8:15:a5:cd:9f:12:70:82:02:f5:02:18:98:
            fb:e4:06:47:2b:5a:78:8e:9f:80:3a:b8:81:81:8f:7d:89:8b:
            5c:70:8a:d7:6f:b7:69:91:f5:42:1c:3d:a8:6d:2a:eb:9e:05:
            c2:e3:5e:63:39:f8:a5:17:d4:bc:6c:43:dd:84:85:b4:ce:ae:
            38:d3:b7:e6:cf:27:9a:7e:fe:36:be:f5:12:03:ad:dd:6e:1a:
            1c:02:05:d5:9d:1a:d1:bd:9f:a1:6a:f9:60:18:4d:27:5e:98:
            30:a3:53:7b:2f:c8:67:4c:43:e4:c2:4b:c1:d7:36:af:eb:86:
            ed:69:1b:96:07:64:53:d5:ba:07:26:e7:d4:08:40:fd:37:3f:
            d9:8a:01:99:a7:87:e9:79:30:6f:a1:14:f0:c4:ad:2f:a1:70:
            b4:9a:90:f5:48:6b:dd:7b:1e:a8:8e:c2:52:5a:90:30:d1:d4:
            30:19:75:12:36:fb:c2:61:cf:9f:63:61:fc:2f:47:8b:02:c8:
            14:2b:03:d5:64:cd:91:7d:13:09:78:31:f7:92:f3:bc:bf:a2:
            fd:9f:ec:12:38:e3:4f:e3:8a:e2:5e:b1:19:ce:4d:7b:f3:62:
            72:c7:de:7e:a3:08:05:b3:9a:63:a6:ce:d2:43:aa:a9:f8:9f:
            5a:02:7c:48:5e:8e:09:10:9d:bf:d2:f4:31:89:7c:0b:54:00:
            03:32:4f:e5:05:b8:2f:5c
      -----BEGIN CERTIFICATE-----
      MIIGkTCCBHmgAwIBAgIBGjANBgkqhkiG9w0BAQsFADCBijEVMBMGCgmSJomT8ixk
      ARkWBWxpYnJlMRQwEgYKCZImiZPyLGQBGRYEYWNtZTEaMBgGCgmSJomT8ixkARkW
      CnBsYXlncm91bmQxEDAOBgNVBAoMB09wZW5OSUMxEzARBgNVBAsMCk9wZW5OSUMg
      Q0ExGDAWBgNVBAMMD09wZW5OSUMgUm9vdCBDQTAeFw0yNDAyMDEyMDA4MzNaFw0y
      NDA4MDEyMDA4MzNaMIGKMRUwEwYKCZImiZPyLGQBGRYFbGlicmUxFDASBgoJkiaJ
      k/IsZAEZFgRhY21lMRowGAYKCZImiZPyLGQBGRYKcGxheWdyb3VuZDEQMA4GA1UE
      CgwHT3Blbk5JQzETMBEGA1UECwwKT3Blbk5JQyBDQTEYMBYGA1UEAwwPT3Blbk5J
      QyBSb290IENBMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqg7QO+YI
      7JHF2WYhRAszoPSbmfegW6X0EqGF3EyXY+4CB9JixkT0GcZoxx+i8VShdtCnQo2x
      J0L+FQRI4Dht0xZhfSEH9Rahnl4IVRWDRkYduVvXaGWRxkQ1UflAJuSbibS4jOe/
      t2Druaoj5VgqRRxsuakw/vBHpRBMXIZYv2TSKeSN5EaFxrYDJytEseAca4E9LxuR
      TkAba4pdHstOqL7dCUv7I9X/0Mkf1AhpPhD3mWLT7wyqkulil8X/eTg/kvT2TLAN
      +4Keusu+ORnkm9+C3mNVJaGaKOp/NysYrzFGs2kHUOMQbtN6wXdlvVd+KYU8MPHG
      +RZijbRIy+h2G7v/K6xqXW+0u5VihxnbrZG58JjfThIvq+IQlEsaGkv4RmYbWRW8
      OD4yw3/GTOj11X9gafVwWxIUcFDo93DyfrQbHT4Jpgc0Nl9UeIYT3AJTPP0UXcr1
      lmpfbr0P29QQZNQ2s1Vq+Pbk8sCEULovW6ARD2q6BSngolPsmDp7ErQwcrXYX+hs
      s9gLqUZ9yGN6+sNVSYmccED6ii8rfU29fHN7Oe4mikigPP8KCvzA1ABfrSpxnqNy
      eO/4N9EFd6jltrvIZ4KRQSzV4GXmXXx/7vOZ7xDOmmQqaaGAVQlkOZBaW2p0PXYy
      UyDMpc91pOrGj7urBIgupKpSC5BHN+e8EXUCAwEAAaOB/zCB/DAOBgNVHQ8BAf8E
      BAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBATAdBgNVHQ4EFgQUoRCMm/RZOy/0irIZ
      Ao+ClOfMa5MwHwYDVR0jBBgwFoAUoRCMm/RZOy/0irIZAo+ClOfMa5MwgZUGA1Ud
      HgEB/wSBijCBh6CBhDAGggQuYmJzMAeCBS5jaGFuMAaCBC5jeWIwBoIELmR5bjAH
      ggUuZ2VlazAJggcuZ29waGVyMAeCBS5pbmR5MAiCBi5saWJyZTAGggQubmVvMAeC
      BS5udWxsMASCAi5vMAaCBC5vc3MwBYIDLm96MAmCBy5wYXJvZHkwCYIHLnBpcmF0
      ZTANBgkqhkiG9w0BAQsFAAOCAgEAjqVnSER+cIuOGL1bc3FfYpefiX9W8kawydjZ
      TZQnVvwuGSu55BvBoUpopkksBrh0VodlapCEg6s9wsRKuDX8xBSWkyN4u69qL61U
      M1M2x3He1yit9sBvV3IDJ4Mbd0dOEBSi+F9YUBu+Afk0xXe28GDA6itkTwj/2vOs
      ojvIuNh4qOi+WSOzdNYAFPDVlZNO9m+7YMClhVFPUT1FAhuLhHR4d/pDUhPyYHiC
      YkEYzpwoutjtUb3WVOOgBABEK9xJdfPYCylS8Sgx2eB564OJKCwG2mveP2WFByhZ
      sx5/Hkc5ipp2Nwn4CSgP0AUirDi4FaXNnxJwggL1AhiY++QGRytaeI6fgDq4gYGP
      fYmLXHCK12+3aZH1Qhw9qG0q654FwuNeYzn4pRfUvGxD3YSFtM6uONO35s8nmn7+
      Nr71EgOt3W4aHAIF1Z0a0b2foWr5YBhNJ16YMKNTey/IZ0xD5MJLwdc2r+uG7Wkb
      lgdkU9W6Bybn1AhA/Tc/2YoBmaeH6Xkwb6EU8MStL6FwtJqQ9Uhr3XseqI7CUlqQ
      MNHUMBl1Ejb7wmHPn2Nh/C9HiwLIFCsD1WTNkX0TCXgx95LzvL+i/Z/sEjjjT+OK
      4l6xGc5Ne/NicsfefqMIBbOaY6bO0kOqqfifWgJ8SF6OCRCdv9L0MYl8C1QAAzJP
      5QW4L1w=
      -----END CERTIFICATE-----
    '')
  ];

  chromiumSuidSandbox.enable = true;

  # allowUserNamespaces = true;
  # unprivilegedUsernsClone = true;
}

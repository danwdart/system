#!/bin/sh
if [[ $1 == "" ]]
then
    echo Usage: $0 [hostname]
    exit 1
fi

mkdir $1
echo Copying hardware config...
cp /etc/nixos/hardware-configuration.nix $1
echo Copying template config...
cp sinistra/configuration.nix $1
echo Updating hostname...
sed -i "s/sinistra/$1/g" $1/configuration.nix
echo Creating private directories...
mkdir -p common/private/{tt-rss,nextcloud,msf,users/{raven,dwd,root}}
echo Creating private files...
touch common/private/{ca-bundle.crt,rootCA.pem,local-cert.pem,sasl_passwd,users/{root,raven,dwd}/hashed_password,tt-rss/{dbpass,email_from_address,email_login,email_password,email_server},nextcloud/{dbpass,adminpass},msf/dbpass}
echo TODO: put junk in the files! Accept emails and hostnames as params etc.
echo TODO the picture file of me

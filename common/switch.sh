sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=$PWD/configuration.nix
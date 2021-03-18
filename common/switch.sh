#!/usr/bin/env bash
nix-channel --update

sudo nix-channel --update
sudo nixos-rebuild switch -I nixos-config=$PWD/configuration.nix
sudo nix-collect-garbage -d
sudo nix-store --optimise
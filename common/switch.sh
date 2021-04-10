#!/usr/bin/env bash
set -e
nix-channel --update
sudo nix-channel --update
sudo nix-collect-garbage -d
nix-store --optimise
nix-store --gc
nix-store --delete
sudo nixos-rebuild switch -I nixos-config=$PWD/configuration.nix
sudo nix-collect-garbage -d
nix-store --optimise
nix-store --gc
nix-store --delete
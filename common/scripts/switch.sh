#!/usr/bin/env bash
# This seems not to be being persisted.
sudo nix-channel --add https://nixos.org/channels/nixos-unstable unstable
sudo nice -19 nixos-rebuild switch --upgrade-all -I nixos-config=$PWD/configuration.nix
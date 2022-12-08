#!/usr/bin/env bash
sudo nice -19 nixos-rebuild switch --fast -I nixos-config=$PWD/configuration.nix $@
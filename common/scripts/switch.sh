#!/usr/bin/env bash
sudo nice -19 nixos-rebuild switch --fast --upgrade-all -I nixos-config=$PWD/configuration.nix
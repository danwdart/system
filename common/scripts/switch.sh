#!/usr/bin/env bash
# This seems not to be being persisted.
sudo nixos-rebuild switch --upgrade-all $@ -I nixos-config=$PWD/configuration.nix
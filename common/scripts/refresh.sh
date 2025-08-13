#!/usr/bin/env bash
sudo nixos-rebuild switch --fast -I nixos-config="$PWD"/configuration.nix $@

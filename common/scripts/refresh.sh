#!/usr/bin/env bash
sudo nixos-rebuild switch --no-reexec -I nixos-config="$PWD"/configuration.nix $@

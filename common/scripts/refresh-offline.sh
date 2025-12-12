#!/usr/bin/env bash
# but is it really offline?
sudo nixos-rebuild switch --no-reexec --option substitute false $@ -I nixos-config="$PWD"/configuration.nix

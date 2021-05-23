#!/usr/bin/env bash
sudo nix-collect-garbage -d
nix-store --optimise
nix-store --gc
nix-store --delete
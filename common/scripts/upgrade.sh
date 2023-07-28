#!/usr/bin/env bash
HERE=$(dirname $0)
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
# sudo nix-store --verify --check-contents --repair
$HERE/update.sh && \
$HERE/switch.sh $@ && \
$HERE/cleanup.sh

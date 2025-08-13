#!/bin/sh
set -euo pipefail
trap pwd ERR

sudo softwareupdate -aiR
nix-channel --update
darwin-rebuild -I darwin-config="$PWD"/darwin-configuration.nix switch --show-trace
nix-collect-garbage -d
brew update
brew upgrade
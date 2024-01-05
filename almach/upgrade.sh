#!/bin/sh
set -euo pipefail
trap pwd ERR

nix-channel --update
darwin-rebuild -I darwin-config=$PWD/darwin-configuration.nix switch --show-trace
nix-collect-garbage -d
brew upgrade
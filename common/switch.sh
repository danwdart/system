#!/usr/bin/env bash
update() {
    nix-channel --update
    sudo nix-channel --update
}

cleanup() {
    sudo nix-collect-garbage -d
    nix-store --optimise
    nix-store --gc
    nix-store --delete
}

switch() {
    sudo nixos-rebuild switch -I nixos-config=$PWD/configuration.nix
}

set -e

update
cleanup
switch
cleanup
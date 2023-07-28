{ pkgs, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
    ++ import ./console/packages.nix pkgs
    ++ import ./gui/packages.nix {pkgs = pkgs;}
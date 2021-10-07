{ pkgs, unstable, ... }:
# Any defaults/must-haves go here
[]
# Any categorical apps go here
    ++ import ./console/packages.nix {pkgs = pkgs; unstable = unstable;}
    ++ import ./gui/packages.nix {pkgs = pkgs; unstable = unstable;}
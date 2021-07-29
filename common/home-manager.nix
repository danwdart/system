{ pkgs, ... }:
{
  home-manager.users.dwd = import ./users/dwd/home.nix pkgs;
}
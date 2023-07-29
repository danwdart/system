{ pkgs, isDesktop, ... }:
{
  users.dwd = import ./users/dwd/home.nix { pkgs = pkgs; isDesktop = isDesktop; };
}

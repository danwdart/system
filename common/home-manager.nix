{ pkgs, isDesktop, ... }:
{
  users.dwd = import ./users/dwd/home.nix { inherit pkgs; inherit isDesktop; };
}

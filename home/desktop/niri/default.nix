{ pkgs, lib, ... }:
{
  programs.niri = {
    config = builtins.readFile ./config.kdl;
    package = pkgs.niri;
  };
}

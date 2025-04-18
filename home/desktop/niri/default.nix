{ pkgs, lib, ... }:
{
  programs.niri = {
    config = builtins.readFile ./config.kdl;
  };
}

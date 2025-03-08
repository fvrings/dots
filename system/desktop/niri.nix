{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    config = builtins.readFile ./config.kdl;
  };
}

{ pkgs, lib, ... }:
{
  home = {
    username = "ring";
    homeDirectory = "/home/ring";

    stateVersion = "24.11";
  };
  xdg = {
    enable = true;
  };
  catppuccin = {
    flavor = "mocha";
    enable = true;
    accent = "rosewater";
  };

}

{ pkgs, ... }:
let
  mpvConf = import ./common.nix { inherit pkgs; };
in

{
  xdg.configFile = {
    "mpv".source = mpvConf;
  };
}

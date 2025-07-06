{ pkgs, ... }:
let
  mpvConf = import ./common.nix { inherit pkgs; };
in

{
  hjem.users.ring = {
    files = {
      ".config/mpv".source = mpvConf;
    };
  };
}

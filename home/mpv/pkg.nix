{ pkgs, ... }:
let
  mpvConf = import ./common.nix { inherit pkgs; };
in
pkgs.writeShellScriptBin "mpv" ''
  # Use --config-dir to tell mpv to load configuration only from our specific path
  exec ${pkgs.mpv}/bin/mpv --config-dir="${mpvConf}" "$@"
''

{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home-manager = {
    users.ring.imports = [
      ./hyprland
      ./niri
      ./theme.nix
      inputs.niri.homeModules.config
    ];
  };
}

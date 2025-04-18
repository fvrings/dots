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
      ./wallpaper.nix
      ./waybar.nix
      inputs.niri.homeModules.config
    ];
  };
}

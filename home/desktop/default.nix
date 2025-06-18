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
      ./theme.nix
      ./wallpaper.nix
      ./waybar.nix
    ];
  };
}

{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.theme
    ./hjem.nix
    ./package.nix
    ./wallpaper.nix
    ./yazi
  ];
}

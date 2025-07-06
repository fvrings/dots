{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.theme
    ./hjem.nix
    ./package.nix
    ./theme.nix
    ./hypridle.nix
    ./yazi
    ./mpv
    ./tmux
    ./matugen
  ];
}

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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ring = ./hm.nix;
  };
}

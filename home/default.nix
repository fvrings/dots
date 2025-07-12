{ inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.theme
    ./service.nix
    ./theme.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ring = ./hm.nix;
    extraSpecialArgs = { inherit inputs; };
  };
}

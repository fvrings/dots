{ lib, inputs, ... }:
{
  imports = [
    inputs.self.nixosModules.theme
    ./link.nix
    ./theme.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.ring = ./hm.nix;
    extraSpecialArgs = { inherit inputs; };
  };

}

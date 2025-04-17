{ inputs, ... }:
{
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
    inputs.ucodenix.nixosModules.default
    inputs.disko.nixosModules.disko
    # inputs.lix-module.nixosModules.default
    inputs.nur.modules.nixos.default
    inputs.sops-nix.nixosModules.sops
    inputs.catppuccin.nixosModules.catppuccin
    inputs.home-manager.nixosModules.home-manager
    inputs.niri.nixosModules.niri
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.impermanence.nixosModules.impermanence
  ];
}

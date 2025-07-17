{ inputs, ... }:
{
  imports = [
    inputs.daeuniverse.nixosModules.dae
    inputs.daeuniverse.nixosModules.daed
    inputs.ucodenix.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.nixos-wsl.nixosModules.default
    inputs.nix-index-database.nixosModules.nix-index
    inputs.nur.modules.nixos.default
    inputs.sops-nix.nixosModules.sops
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.maomaowm.nixosModules.maomaowm
    inputs.impermanence.nixosModules.impermanence
    inputs.chaotic.nixosModules.default
    # inputs.lix-module.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ];
}

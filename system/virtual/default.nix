{ ... }:
{
  imports = [
    ../core.nix
    ../theme.nix
    ../service
    ../dae.nix
    ../package.nix
    ../fonts.nix
    ../nixconfig.nix
    ../sops.nix
    ../network.nix
    ../virtual.nix
    ../boot.nix
    ./hardware-configuration.nix
  ];
}

{ ... }:
{
  imports = [
    ../core.nix
    ../theme.nix
    ../service
    ../package.nix
    ../fonts.nix
    ../nixconfig.nix
    ../sops.nix
    ../network.nix
    ../virtual.nix
    ../boot.nix
    ./hardware-configuration.nix
    ./disk.nix
    ./impermanence.nix
  ];
}

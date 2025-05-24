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
    ../boot.nix
  ];
}

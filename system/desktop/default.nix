{ ... }:
{
  imports = [
    ./login-manager.nix
    ./niri
    ./steam.nix
    ./hardware.nix
    ./service
    ./hardware-configuration.nix
    ../disko
    ./power.nix
    ./fcitx.nix
    ./stylix.nix

    ../core.nix
    ../dae.nix
    ../special.nix
    ../package.nix
    ./desktop-package.nix
    ../fonts.nix
    ../nixconfig.nix
    ../sops.nix
    ../network.nix
    ../virtual.nix
    ../boot.nix
    ./lanzaboote.nix

    ./luks-disk.nix
    # ../impermanence.nix
  ];

}

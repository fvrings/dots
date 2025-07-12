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

    ../core.nix
    ../dwl
    ../mutt.nix
    ../dae.nix
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

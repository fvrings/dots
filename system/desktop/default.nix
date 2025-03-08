{ ... }:
{
  imports = [
    ./hyprland.nix
    ./gnome.nix
    ./hardware.nix
    ./service
    ./hardware-configuration.nix
    ./fcitx.nix
    ./niri.nix

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
  ];

  # disable ATM
  # services.ucodenix = {
  #   enable = false;
  #   cpuModelId = "00A50F00"; # Replace with your processor's model ID
  # };
}

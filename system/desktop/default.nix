{ ... }:
{
  imports =
    # TODO: have to find a way to optionally enable windowManager
    # if osConfig.networking.hostName == "art" then
    [
      ./hyprland.nix
      ./gnome.nix
      ./hardware.nix
      ./service
      ./hardware-intel.nix
      ../disko
      ./fcitx.nix

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

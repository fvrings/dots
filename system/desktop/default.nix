{ ... }:
{
  imports =
    # TODO: have to find a way to optionally enable windowManager
    # if osConfig.networking.hostName == "art" then
    [
      ./hyprland.nix
      ./gnome.nix
      ./steam.nix
      ./hardware.nix
      ./service
      ./hardware-configuration.nix
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
      # ../impermanence.nix
    ];

  services.ucodenix = {
    enable = true;
  };
}

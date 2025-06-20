{ ... }:
{
  imports =
    # TODO: have to find a way to optionally enable windowManager
    # if osConfig.networking.hostName == "art" then
    [
      ./display-manager.nix
      ./niri
      ./gnome.nix
      ./steam.nix
      ./hardware.nix
      ./service
      ./hardware-configuration.nix
      ../disko
      ./fcitx.nix

      ../core.nix
      ../service
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

  services.ucodenix = {
    enable = true;
  };
  # boot.kernelParams = [ "microcode.amd_sha_check=off" ];
}

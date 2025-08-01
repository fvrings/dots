{ pkgs, inputs, ... }:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;

  };

  # stylix.targets.niri.enable = false;
  programs.mango.enable = false;

}

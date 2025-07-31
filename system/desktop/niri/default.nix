{ pkgs, inputs, ... }:
# let
#   swww = "swww.service";
# in
{
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
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  # imports = [
  #   inputs.niri.nixosModules.niri
  # ];
}

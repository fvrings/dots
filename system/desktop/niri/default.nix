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
    # use nyx
    package = pkgs.niri-unstable;
  };
  programs.maomaowm.enable = true;
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  # imports = [
  #   inputs.niri.nixosModules.niri
  # ];
}

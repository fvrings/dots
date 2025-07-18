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
    # BUG:does not close window cleanly
    # package = pkgs.niri-unstable;
    package = pkgs.niri;

  };

  # stylix.targets.niri.enable = false;
  programs.maomaowm.enable = true;
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  # imports = [
  #   inputs.niri.nixosModules.niri
  # ];
}

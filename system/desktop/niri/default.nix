{ pkgs, ... }:
# let
#   swww = "swww.service";
# in
{
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
  programs.niri = {
    enable = true;
    # use nyx
    package = pkgs.niri_git;
  };
  # nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  # imports = [
  #   inputs.niri.nixosModules.niri
  # ];
}

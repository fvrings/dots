{ pkgs, inputs, ... }:
# let
#   swww = "swww.service";
# in
{
  environment.systemPackages = with pkgs; [ xwayland-satellite ];
  # programs.fuzzel.enable = true;
  # services.swww.enable = true;
  # systemd.user.services.swww-img = {
  #   Install = {
  #     WantedBy = [ swww ];
  #   };
  #
  #   Unit = {
  #     Description = "swww image setter";
  #     After = [ swww ];
  #     Requires = [ swww ];
  #   };
  #
  #   Service = {
  #     ExecStart = "swww img ${config.theme.wallpaper}";
  #     Restart = "on-failure";
  #     RestartSec = 10;
  #   };
  # };
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    #TODO: configure options here
    # config = builtins.readFile ./config.kdl;
  };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  imports = [
    inputs.niri.nixosModules.niri
  ];
}

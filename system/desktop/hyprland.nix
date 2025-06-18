{
  pkgs,
  inputs,
  ...
}:
{
  # programs.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #   portalPackage =
  #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  # };

  services = {
    gvfs.enable = true;
    # displayManager.gdm.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        load = true;
        save = false;
        animation = "colormix";
        bigclock = "en";
        blank_box = false;
      };
    };
    # displayManager = {
    #   defaultSession = "hyprland";
    # };
  };

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    # extraPortals = [
    #   pkgs.xdg-desktop-portal-gtk
    # ];
  };

  security.pam.services.hyprlock = { };
}

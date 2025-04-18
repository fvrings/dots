{
  pkgs,
  inputs,
  ...
}:
{
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-stable;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  services = {
    gvfs.enable = true;
    xserver.displayManager.gdm.enable = true;
    displayManager = {
      defaultSession = "hyprland";
    };
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

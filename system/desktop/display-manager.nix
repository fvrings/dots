{ pkgs, ... }:
{

  services = {
    gvfs.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        load = true;
        save = false;
        animation = "colormix";
        bigclock = "en";
        blank_box = false;
        clock = "%Y %a %b %d %X";
      };
    };
  };

  xdg.portal = {
    # enable = true;
    # xdgOpenUsePortal = true;
    # extraPortals = with pkgs; [
    #   xdg-desktop-portal-gtk
    #   xdg-desktop-portal-gnome
    # ];
    # config = {
    #   common.default = [ "gtk" ];
    # };

  };

}

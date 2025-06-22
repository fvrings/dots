_: {

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
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
    };

  };

  security.pam.services.hyprlock = { };
}

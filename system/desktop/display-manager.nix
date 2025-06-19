{
  pkgs,
  inputs,
  ...
}:
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
      };
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common.default = [ "gtk" ];
    };

  };

  security.pam.services.hyprlock = { };
}

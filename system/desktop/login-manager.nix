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

}

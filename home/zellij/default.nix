{
  programs.zellij.enable = true;
  xdg.configFile = {
    "zellij/config.kdl" = {
      source = ./config.kdl;
    };
    "zellij/layouts" = {
      source = ./layouts;
    };
  };
}

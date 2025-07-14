{
  wayland.windowManager.maomaowm = {
    enable = true;
    # systemd.enable = true;
    settings = builtins.readFile ./config.maomao;
  };
}

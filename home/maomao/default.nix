{
  wayland.windowManager.mango = {
    enable = true;
    # systemd.enable = true;
    settings = builtins.readFile ./config.maomao;
  };
}

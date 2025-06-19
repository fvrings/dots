{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = config.theme.wallpaper;
        }
      ];
    };
  };
}

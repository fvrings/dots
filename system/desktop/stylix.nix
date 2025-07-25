{ pkgs, ... }:
{
  stylix = {
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
    polarity = "dark";
    enable = true;
    autoEnable = true;
    cursor = {
      name = "LyraF-cursors";
      package = pkgs.lyra-cursors;
      size = 22;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
      monospace = {
        name = "Iosevka";
        package = pkgs.iosevka;
      };
      sansSerif = {
        name = "Aporetic Sans";
        package = pkgs.aporetic;
      };
      serif = {
        name = "Aporetic Serif";
        package = pkgs.aporetic;
      };
      sizes = {
        popups = 18;
        applications = 15;
        desktop = 15;
        terminal = 15;
      };
    };

    opacity.applications = 0.8;
    opacity.terminal = 0.88;
    targets.console.enable = true;
  };

}

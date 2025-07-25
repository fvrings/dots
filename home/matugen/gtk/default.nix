{ lib, pkgs, ... }:
{
  gtk = {
    enable = true;
    # font.name = "LXGW WenKai Bold";
    # font.size = 14;
    # iconTheme.name = "BeautyLine";
    # cursorTheme.name = "LyraF-cursors";
    theme.name = lib.mkDefault "Kanagawa-B";
    theme.package = lib.mkDefault pkgs.kanagawa-gtk-theme;
    # cursorTheme.size = 22;
  };
  stylix.targets.gtk.extraCss = "@import 'colors.css';";
  dconf.settings = lib.mkForce {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

}

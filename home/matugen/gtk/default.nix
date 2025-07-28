{ lib, pkgs, ... }:
{
  gtk = {
    enable = true;
    # font.name = "LXGW WenKai Bold";
    # font.size = 14;
    # iconTheme.name = "BeautyLine";
    # cursorTheme.name = "LyraF-cursors";
    theme.name = lib.mkOverride 99 "Kanagawa-B";
    theme.package = lib.mkOverride 99 pkgs.kanagawa-gtk-theme;
    # cursorTheme.size = 22;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
  # stylix.targets.gtk.extraCss = "@import 'colors.css';";
  dconf.settings = lib.mkForce {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

}

{ pkgs, lib, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
  gtk = {
    # catppuccin.enable = true;
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 38;
    };
    theme = {
      name = lib.mkForce "rose-pine";
      package = lib.mkForce pkgs.rose-pine-gtk-theme;
    };
  };

  xdg = {
    dataFile = {
      "fcitx5/themes".source = "${pkgs.fcitx5-rose-pine}/share/fcitx5/themes";
    };
  };
}

{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
  };

  # xdg = {
  #   dataFile = {
  #     "fcitx5/themes".source = "${pkgs.fcitx5-rose-pine}/share/fcitx5/themes";
  #   };
  # };
}

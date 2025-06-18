{ pkgs, lib, ... }:
{
  gtk = {
    enable = true;
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

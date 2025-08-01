{
  lib,
  pkgs,
  config,
  ...
}:
let
  theme = "gruvbox-material-light-soft";
in
{
  imports = [
    ./doas.nix
  ];
  specialisation.${theme}.configuration = {
    environment.etc."specialisation".text = theme; # this is for 'nh' to correctly recognise the specialisation
    # you have to force the values to override those declared in base configuration, which this specialisation automatically inherits
    stylix.base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/${theme}.yaml";
    # feel free to add here more changes to base configuration from your Nixos options

    home-manager.users.ring = {
      theme.wallpaper = lib.mkForce config.theme.wallpaper-anime;
      dconf.settings = lib.mkForce {
        "org/gnome/desktop/interface" = {
          color-scheme = lib.mkForce "prefer-light";
        };
      };
      gtk = {
        enable = true;
        theme.name = lib.mkForce "Gruvbox-Light";
        theme.package = lib.mkForce pkgs.gruvbox-gtk-theme;

        gtk3.extraConfig.gtk-application-prefer-dark-theme = lib.mkForce 0;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = lib.mkForce 0;
      };
    };

  };
}

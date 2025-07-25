{ lib, pkgs, ... }:
{
  specialisation.light.configuration = {
    environment.etc."specialisation".text = "light"; # this is for 'nh' to correctly recognise the specialisation
    # you have to force the values to override those declared in base configuration, which this specialisation automatically inherits
    stylix.base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-soft.yaml";
    # feel free to add here more changes to base configuration from your Nixos options

    home-manager.users.ring = {
      # change gtk theme
      # gtk.theme.name = lib.mkForce "Catppuccin-Latte-Compact-Lavender-light";
      # change dark/light preference to trigger the change in darkreader web-browser extension, which has to be set on 'auto' to 'use system color scheme'
      dconf.settings = lib.mkForce {
        "org/gnome/desktop/interface" = {
          color-scheme = lib.mkForce "prefer-light";
        };
      };
      gtk = {
        enable = true;
        theme.name = lib.mkForce "Gruvbox-Light";
        theme.package = lib.mkForce pkgs.gruvbox-gtk-theme;
      };
    };

  };
  security.doas = {
    enable = true;
    extraRules = [
      {
        users = [ "ring" ];
        keepEnv = true;
        persist = true;
      }
      # Allow your user to run switch-to-specialisation and back without a password
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
      {
        groups = [ "wheel" ];
        cmd = "/nix/var/nix/profiles/system/bin/switch-to-configuration";
        args = [ "switch" ];
        runAs = "root";
        noPass = true;
      }
    ];
  };
}

{ pkgs, ... }:
{
  imports = [
    ./gtk.nix
    ./ghostty
    ./qt.nix
    ./fuzzel.nix
    ./alacritty.nix
  ];

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "use-kanagawa" ''

      rm ~/.config/gtk-3.0/colors.css
      rm ~/.config/gtk-4.0/colors.css

      rm ~/.config/ghostty/themes/matugen

      rm ~/.config/qt5ct/colors/matugen.conf
      rm ~/.config/qt6ct/colors/matugen.conf

      rm ~/.config/fuzzel/colors.ini

      rm ~/.config/alacritty/colors.ini

      rm -r ~/.config/kitty
    '')
  ];
  hjem.users.ring = {
    packages = with pkgs; [
      matugen
      swww
    ];
    files = {
      ".config/matugen/config.toml".source = pkgs.writers.writeTOML "config.toml" {
        config = {
          wallpaper = {
            command = "swww";
            arguments = [
              "img"
              "--transition-type"
              "center"
            ];
            set = true;
          };
        };
        templates = {
          gtk3 = {
            input_path = ./templates/gtk-colors.css;
            output_path = "~/.config/gtk-3.0/colors.css";
          };
          gtk4 = {
            input_path = ./templates/gtk-colors.css;
            output_path = "~/.config/gtk-4.0/colors.css";
          };
          ghostty = {
            input_path = ./templates/ghostty;
            output_path = "~/.config/ghostty/themes/matugen";
          };
          fuzzel = {
            input_path = ./templates/fuzzel.ini;
            output_path = "~/.config/fuzzel/colors.ini";
          };
          qt5ct = {
            input_path = ./templates/qtct-colors.conf;
            output_path = "~/.config/qt5ct/colors/matugen.conf";
          };
          qt6ct = {
            input_path = ./templates/qtct-colors.conf;
            output_path = "~/.config/qt6ct/colors/matugen.conf";
          };
          kitty = {
            input_path = ./templates/kitty-colors.conf;
            output_path = "~/.config/kitty/kitty-colors.conf";
          };
          alacritty = {
            input_path = ./templates/alacritty.toml;
            output_path = "~/.config/alacritty/colors.toml";
          };
          # niri = {
          #   input_path = ./templates/niri.kdl;
          #   output_path = "~/.config/niri/config.kdl";
          # };
        };
      };
    };
  };
}

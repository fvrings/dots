{ pkgs, lib, ... }:
let
  getSubdirs =
    folder:
    let
      flakeRootContents = builtins.readDir folder;
      directoriesOnly = lib.filterAttrs (
        name: type: type == "directory" && name != "templates"
      ) flakeRootContents;
      directoryNames = builtins.attrNames directoriesOnly;

      # Map the names to their full absolute paths
      directoryPaths = builtins.map (name: folder + "/${name}") directoryNames;
    in
    directoryPaths;
  subdirectories = getSubdirs ./.;

in
{
  imports = subdirectories;

  home = {
    packages = with pkgs; [
      matugen
      swww
      (pkgs.writeShellScriptBin "use-kanagawa" ''

        rm ~/.config/gtk-3.0/colors.css
        rm ~/.config/gtk-4.0/colors.css

        rm ~/.config/ghostty/matugen

        rm ~/.config/qt5ct/colors/matugen.conf
        rm ~/.config/qt6ct/colors/matugen.conf

        rm ~/.config/fuzzel/matugen.ini

        rm ~/.config/alacritty/matugen.toml

        rm ~/.config/kitty/matugen.conf
      '')
    ];
    file = {
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
            post_hook = "echo 'theme = matugen' |save -f ~/.config/ghostty/matugen";
          };
          fuzzel = {
            input_path = ./templates/fuzzel.ini;
            output_path = "~/.config/fuzzel/matugen.ini";
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
            output_path = "~/.config/kitty/matugen.conf";
          };
          alacritty = {
            input_path = ./templates/alacritty.toml;
            output_path = "~/.config/alacritty/matugen.toml";
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

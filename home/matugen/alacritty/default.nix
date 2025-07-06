{ pkgs, ... }:
{
  hjem.users.ring = {
    packages = [ pkgs.alacritty_git ];
    files = {
      ".config/alacritty/alacritty.toml".source = pkgs.writers.writeTOML "alacritty.toml" {
        font = {
          size = 13;
        };
        window = {
          decorations = "none";
        };
        general = {
          import = [
            "kanagawa.toml"
            "matugen.toml"
          ];
        };
      };
      ".config/alacritty/kanagawa.toml".source =
        "${pkgs.alacritty-theme}/share/alacritty-theme/kanagawa_dragon.toml";
    };
  };
}

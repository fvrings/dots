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
          import = [ "colors.toml" ];
        };
      };
    };
  };
}

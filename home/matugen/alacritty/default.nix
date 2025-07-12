{ pkgs, ... }:
{
  home = {
    file = {
      ".config/alacritty/kanagawa.toml".source =
        "${pkgs.alacritty-theme}/share/alacritty-theme/kanagawa_dragon.toml";
    };
  };
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty_git;
    settings = {
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

  };
}

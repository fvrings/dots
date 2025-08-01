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
      # font = {
      #   size = 13;
      # };
      window = {
        decorations = "none";
        # opacity = 0.8;
      };
      # general = {
      #   import = [
      #     "kanagawa.toml"
      #   ];
      # };
    };

  };
}

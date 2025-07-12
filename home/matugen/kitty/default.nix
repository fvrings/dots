{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font.size = 12;
    font.name = "monospace";
    settings = {
      shell_integration = "no-rc";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary no-append";
      hide_window_decorations = true;
      remember_window_size = true;
    };

    extraConfig = ''
      include ${pkgs.kitty-themes}/share/kitty-themes/themes/kanagawa_dragon.conf
      include matugen.conf
    '';
  };
}

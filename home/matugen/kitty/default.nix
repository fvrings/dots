{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      shell_integration = "enabled";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary no-append";
      hide_window_decorations = true;
      remember_window_size = true;
      enabled_layouts = "tall";
      allow_remote_control = true;
      listen_on = "unix:/tmp/kitty";
    };
    keybindings = {
      "alt+shift+w" = "launch --location=split";
      "alt+w" = "new_tab";
      "alt+n" = "next_tab";
      "alt+p" = "previous_tab";
      "alt+q" = "kitten conditional_alt_q.py";
      "alt+s" = "kitty_scrollback_nvim";
      "alt+shift+s" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
      "alt+k" = "neighboring_window up";
      "alt+h" = "neighboring_window left";
      "alt+l" = "neighboring_window right";
      "alt+j" = "neighboring_window down";
    };

    actionAliases = {
      "kitty_scrollback_nvim" =
        "kitten ~/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
    };
    extraConfig = ''
      # include ${pkgs.kitty-themes}/share/kitty-themes/themes/kanagawa_dragon.conf
      # include matugen.conf
    '';
  };
  home.file = {
    ".config/kitty/conditional_alt_q.py".text = builtins.readFile ./conditional_alt_q.py;

  };
}

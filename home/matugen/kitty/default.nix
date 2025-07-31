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
      "alt+shift+w" = "launch --location=split --cwd=current";
      "alt+w" = "new_tab_with_cwd";
      "alt+n" = "next_tab";
      "alt+p" = "previous_tab";
      "alt+q" = "custom_alt_map q";
      "alt+s" = "kitty_scrollback_nvim";
      "alt+shift+s" = "kitty_scrollback_nvim --config ksb_builtin_last_cmd_output";
      "alt+k" = "custom_alt_map k";
      "alt+h" = "custom_alt_map h";
      "alt+l" = "custom_alt_map l";
      "alt+j" = "custom_alt_map j";
    };

    actionAliases = {
      "kitty_scrollback_nvim" =
        "kitten ~/.local/share/nvim/lazy/kitty-scrollback.nvim/python/kitty_scrollback_nvim.py";
      "custom_alt_map" = "kitten ~/.config/kitty/custom_alt_map.py";

    };
    extraConfig = ''
      # include ${pkgs.kitty-themes}/share/kitty-themes/themes/kanagawa_dragon.conf
      # include matugen.conf
    '';
  };
  home.file = {
    ".config/kitty/custom_alt_map.py".text = builtins.readFile ./custom_alt_map.py;

  };
}

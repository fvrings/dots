{
  config,
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs)
    yazi-plugins
    yazi-starship
    yatline
    ;
in
{
  programs.yazi = {
    package = inputs.yazi.packages.${pkgs.system}.default;
    enable = true;
    enableNushellIntegration = true;
    plugins = {
      smart_enter = "${yazi-plugins}/smart-enter.yazi";
      chmod = "${yazi-plugins}/chmod.yazi";
      mount = "${yazi-plugins}/mount.yazi";
      git = "${yazi-plugins}/git.yazi";
      jump_to_char = "${yazi-plugins}/jump-to-char.yazi";
      yatline = "${yatline}";
      starship = "${yazi-starship}";
    };
    initLua = builtins.readFile ./yazi.lua;
    keymap = {
      manager.prepend_keymap = [
        {
          on = "l";
          run = "plugin smart_enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = "f";
          run = "plugin jump_to_char";
          desc = "Jump to char";
        }
        {
          on = "M";
          run = "plugin mount";
          desc = "Mount";
        }
      ];
    };
    settings = {
      manager = {
        ratio = [
          1
          3
          3
        ];
        sort_by = "natural";
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = false;
        show_symlink = true;
        linemode = "size";
      };
      preview = {
        cache_dir = "${config.xdg.cacheHome}";
        max_height = 900;
        max_width = 600;
      };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}

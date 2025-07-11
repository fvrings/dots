{
  inputs,
  pkgs,
  ...
}:
let
  inherit (inputs)
    yazi-plugins
    yazi-starship
    bunny
    ouch
    rich-preview
    yazi-fast-enter
    yazi-kanagawa
    ;

in
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.system}.default;
    flavors = {
      "kanagawa" = "${yazi-kanagawa}";
    };
    plugins = {
      "chmod" = "${yazi-plugins}/chmod.yazi";
      "mime-ext" = "${yazi-plugins}/mime-ext.yazi";
      "fast_enter" = "${yazi-fast-enter}";
      "ouch" = "${ouch}";
      "mount" = "${yazi-plugins}/mount.yazi";
      "git" = "${yazi-plugins}/git.yazi";
      "jump_to_char" = "${yazi-plugins}/jump-to-char.yazi";
      "bunny" = "${bunny}";
      "rich-preview" = "${rich-preview}";
      "starship" = "${yazi-starship}";
    };
    initLua = ./yazi.lua;
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "C";
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = ";";
          run = "plugin bunny";
          desc = "Start bunny";
        }
        {
          on = "'";
          run = "plugin bunny fuzzy";
          desc = "Start fuzzy bunny";
        }
        {
          on = "l";
          run = "plugin fast_enter";
          desc = "Enter the subfolder faster, or open the file directly";
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
        {
          on = "e";
          run = "shell --block -- nvim -c 'ContinueLoad'";
          desc = "open cwd with neovim";
        }
      ];
    };
    settings = {
      theme = {
        flavor = {
          dark = "kanagawa";
        };
      };
      yazi = {
        mgr = {
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
            id = "mime";
            name = "*";
            run = "mime-ext";
            prio = "high";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };
  };
}

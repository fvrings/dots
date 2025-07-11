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
    package = inputs.yazi.packages.${pkgs.system}.default;
    enable = true;
    flavors = {
      "kanagawa.yazi" = "${yazi-kanagawa}";
    };
    plugins = {
      "chmod.yazi" = "${yazi-plugins}/chmod.yazi";
      "mime-ext.yazi" = "${yazi-plugins}/mime-ext.yazi";
      "fast_enter.yazi" = "${yazi-fast-enter}";
      "ouch.yazi" = "${ouch}";
      "mount.yazi" = "${yazi-plugins}/mount.yazi";
      "git.yazi" = "${yazi-plugins}/git.yazi";
      "jump_to_char.yazi" = "${yazi-plugins}/jump-to-char.yazi";
      "bunny.yazi" = "${bunny}";
      "rich-preview.yazi" = "${rich-preview}";
      "starship.yazi" = "${yazi-starship}";
    };
    initLua = ./yazi.lua;
    settings = {
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
          # cache_dir = "${config.xdg.cacheHome}";
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
      theme = {
        flavor = {
          dark = "kanagawa";
        };
      };
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
    };
  };
}

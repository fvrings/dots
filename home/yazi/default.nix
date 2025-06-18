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
    bunny
    yatline-catppuccin
    ouch
    rich-preview
    yazi-fast-enter
    ;
  # yatline' = pkgs.stdenv.mkDerivation {
  #   pname = "yatline";
  #   version = "patched";
  #
  #   src = yatline;
  #
  #   patches = [ ./yatline.patch ];
  #   patchFlags = [ "-p0" ];
  #   installPhase = ''
  #     mkdir -p $out
  #     cp main.lua $out/
  #   '';
  #
  # };
in
{
  programs.yazi = {
    package = inputs.yazi.packages.${pkgs.system}.default;
    enable = true;
    enableNushellIntegration = true;
    plugins = {
      chmod = "${yazi-plugins}/chmod.yazi";
      fast_enter = "${yazi-fast-enter}";
      ouch = "${ouch}";
      mount = "${yazi-plugins}/mount.yazi";
      git = "${yazi-plugins}/git.yazi";
      jump_to_char = "${yazi-plugins}/jump-to-char.yazi";
      yatline = "${yatline}";
      bunny = "${bunny}";
      yatline-catppuccin = "${yatline-catppuccin}";
      rich-preview = "${rich-preview}";
      starship = "${yazi-starship}";
    };
    initLua = builtins.readFile ./yazi.lua;
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
      ];
    };
    settings = {
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
      plugin.prepend_previewers = [
        {
          name = "*.csv";
          run = "rich-preview";
        }
        {
          name = "*.md";
          run = "rich-preview";
        }
        {
          name = "*.rst";
          run = "rich-preview";
        }
        {
          name = "*.ipynb";
          run = "rich-preview";
        }
        {
          name = "*.json";
          run = "rich-preview";
        }

      ];
    };
  };
}

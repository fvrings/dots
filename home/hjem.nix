{
  pkgs,
  lib,
  config,
  ...
}:

let
  user = "ring";
  swww = "swww.service";
  graphical = "niri.service";
  anime4K_Input = ''
    # Optimized shaders for lower-end GPU:
    CTRL+1 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"
    CTRL+2 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"
    CTRL+3 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"
    CTRL+4 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_S.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"
    CTRL+5 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_S.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"
    CTRL+6 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_S.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"

    CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
  '';
  combinedInputConf = pkgs.writeText "input.conf" (
    (builtins.readFile ../config/mpv/input.conf) + anime4K_Input
  );
  mpvConf = pkgs.linkFarm "mpv" [
    {
      name = "mpv.conf";
      path = ../config/mpv/mpv.conf;
    }
    {
      name = "scripts/uosc";
      path = "${pkgs.mpvScripts.uosc}/share/mpv/scripts/uosc";
    }
    {
      name = "scripts/thumbfast.lua";
      path = "${pkgs.mpvScripts.thumbfast}/share/mpv/scripts/thumbfast.lua";
    }
    {
      name = "input.conf";
      path = combinedInputConf;
    }
  ];
  generateRecursiveFileMapping =
    des: ori:
    let
      currentDirContents = builtins.readDir ori;
      itemNames = builtins.attrNames currentDirContents;
    in
    lib.foldl' (
      acc: name:
      let
        fullPath = "${ori}/${name}";
        type = currentDirContents.${name};
      in
      if type == "regular" then
        # The .source attribute is for Home Manager's file declarations
        acc // { "${des}/${name}".source = fullPath; }
      else if type == "directory" then
        lib.recursiveUpdate acc (generateRecursiveFileMapping "${des}/${name}" fullPath)
      else
        acc
    ) { } itemNames; # Start with an empty attribute set `{}` as the initial accumulator.

  generateFileMappingsFromAttrset =
    mappingsAttrset:
    # 1. Map over the input attribute set.
    #    For each 'des' (key) and 'ori' (value) pair:
    #    Call generateRecursiveFileMapping and get its result (an attrset of file declarations).
    #    This produces a list of attribute sets.
    let
      listOfFileAttrsets = lib.attrsets.mapAttrsToList (
        des: ori: generateRecursiveFileMapping des ori
      ) mappingsAttrset;
    in
    # 2. Merge all the attribute sets in the list into a single, combined attribute set.
    lib.attrsets.mergeAttrsList listOfFileAttrsets;

  symLink = config: "L+ /home/${user}/.config/${config} - - - - /etc/nixos/dots/config/${config}";

in

{
  systemd.user = {
    services.swww-img = {
      enable = true;
      wantedBy = [ swww ];

      description = "swww image setter";
      after = [ swww ];
      requires = [ swww ];

      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww img ${config.theme.wallpaper}";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
    services.swww = {
      enable = true;
      wantedBy = [ graphical ];

      description = "swww-daemon";
      after = [ graphical ];
      partOf = [ graphical ];

      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
        RestartSec = 1;
      };
    };
    tmpfiles.users.ring.rules = [
      (symLink "ghostty")
      (symLink "nushell")
      (symLink "niri")
      (symLink "nvim")
    ];
  };
  hjem.users.ring = {
    files =
      generateFileMappingsFromAttrset {
        ".config/hypr/scripts" = ./desktop/scripts;
        ".config/git" = ../config/git;
        ".config/alacritty" = ../config/alacritty;
        ".config/uv" = ../config/uv;
        ".config/foot" = ../config/foot;
        ".config/direnv" = ../config/direnv;
        ".config/emacs" = ../config/emacs;
        ".config/zellij" = ../config/zellij;
        ".config/guix" = ../config/guix;
        ".config/bat" = ../config/bat;
        ".config/imv" = ../config/imv;
        ".config/btop" = ../config/btop;
        ".config/lazygit" = ../config/lazygit;
      }
      // {
        ".config/mpv".source = mpvConf;
        ".config/tmux/tmux-or-nvim-kill.sh".source = ../config/tmux/tmux-or-nvim-kill.sh;
        ".config/hypr/hyprlock.conf".text = ''
          background {
            path=${config.theme.wallpaper}
          }
        '';
        ".config/mimeapps.list".source = ../config/mimeapps.list;
        ".npmrc".source = ../config/.npmrc;
        ".config/nix-extra/sqlite3.path".text = "${pkgs.sqlite.out}/lib/libsqlite3.so";
        ".cargo/config.toml".text =
          (builtins.readFile ../config/.cargo/config.toml)
          + ''
            [target.x86_64-unknown-linux-gnu]
            linker = "clang"
              rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"]
          '';
        ".config/kitty/kitty.conf".text =
          (builtins.readFile ../config/kitty/kitty.conf)
          + ''
            include ${pkgs.kitty-themes}/share/kitty-themes/themes/kanagawa_dragon.conf
          '';
        ".config/zathura/zathurarc".source = ../config/zathura/zathurarc;
      };
  };
}

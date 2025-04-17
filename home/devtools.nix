{
  pkgs,
  config,
  inputs,
  ...
}:
with pkgs;
let
  lsp = [
    # nil
    nixd
    zls
    nodePackages."@astrojs/language-server"
    # nodePackages."@prisma/language-server"
    # typst-lsp
    marksman
    nodePackages_latest.typescript-language-server
    vscode-langservers-extracted
    typescript
    vtsls
    rustywind
    selene
    gopls
    emmet-language-server
    tailwindcss-language-server
    pyright
    basedpyright
    sumneko-lua-language-server
    rust-analyzer
    cmake-language-server
    ruff
    bash-language-server
    deadnix
    statix
    # solc
  ];
  formatter = [
    taplo
    rustfmt
    google-java-format
    nixfmt-rfc-style
    cmake-format
    shfmt
    stylua
    black
    biome
    fnlfmt
    typstfmt
  ];
  tools = [
    cowsay
    # manix
    htop-vim
    fastfetch
    commitizen
    nodePackages.conventional-changelog-cli
    exiftool
    tealdeer
    dust
    delta
    ueberzugpp
  ];
  shtools = [
    zip
    killall
    xz
    file
    which
    gnused
    gnutar
    gawk
    zstd
    gnupg
    unzip
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
    lolcat
    toilet
    p7zip
    fd
    ripgrep
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
  ];
  inherit (config.lib.file) mkOutOfStoreSymlink;
  browser = [ "firefox" ];
  imageViewer = [ "imv" ];
  videoPlayer = [ "mpv" ];

  xdgAssociations =
    type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      }) list
    );

  image = xdgAssociations "image" imageViewer [
    "png"
    "svg"
    "jpeg"
  ];
  video = xdgAssociations "video" videoPlayer [
    "mp4"
    "avi"
    "mkv"
  ];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);
  #from xddxdd https://github.com/xddxdd/nixos-config/blob/362feb5732efe1682b505d941b75c97279d2208c/home/client-apps/mpv.nix
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

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      "application/pdf" = [ "org.pwmt.zathura" ];
      "application/epub+zip" = [ "org.pwmt.zathura" ];
      "text/html" = browser;
      "text/plain" = [ "nvim" ];
      "x-scheme-handler/chrome" = [ "chromium-browser" ];
      "inode/directory" = [ "yazi" ];
      "image/gif" = [ "mpv" ];
    }
    // image
    // video
    // browserTypes
  );
in
{
  programs = {
    fish.enable = true;
    git = {
      enable = true;
      userName = "fvrings";
      userEmail = "fvrings@proton.me";
      extraConfig = {
        # http.postBuffer = "4096M";
        http.version = "HTTP/1.1";
        credential = {
          helper = "store";
        };
      };
      ignores = [
        ".direnv"
        "node_modules"
      ];
    };
    bat.enable = true;
    gitui.enable = true;
    imv.enable = true;
    mpv = {
      enable = true;
      config = {
        hwdec = "auto-safe";
        vo = "gpu-next";
        profile = "high-quality";
        gpu-api = "vulkan";
        osd-bar = false;
        target-colorspace-hint = true;
        save-position-on-quit = true;
        keep-open = true;
        alang = "chi,zho,zh,zh-CN,zh-TW,zh-HK,zh-MO";
        slang = "chi,zho,zh,zh-CN,zh-TW,zh-HK,zh-MO";
        screenshot-format = "png";
        screenshot-dir = "~/Pictures/mpv/";
      };
      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
      ];
      extraInput =
        anime4K_Input
        + ''
          space           cycle pause; script-binding uosc/flash-pause-indicator
          m               no-osd cycle mute; script-binding uosc/flash-volume
          [               no-osd add speed -0.25; script-binding uosc/flash-speed
          ]               no-osd add speed  0.25; script-binding uosc/flash-speed
          BS              no-osd set speed 1; script-binding uosc/flash-speed
          >               script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline
          <               script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline
          MBTN_RIGHT_DBL  script-binding uosc/menu
        '';
      scriptOpts = {
        uosc = {
          languages = "slang,zh-hans";
          pause_indicator = "manual";
        };
      };
    };
    zellij.enable = true;
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    zoxide = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    starship = {
      enable = true;
      settings = {
        character = {
          success_symbol = "👾";
          error_symbol = "💔";
        };
        hostname = {
          ssh_symbol = "🏄 ";
        };
      };
    };

    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = extrakto;
          extraConfig = ''
            set -g @extrakto_key "f"
          '';
        }
        vim-tmux-navigator
        resurrect
        tmux-fzf
        fzf-tmux-url
        {
          plugin = tokyo-night-tmux;
          extraConfig = ''
            set -g @tokyo-night-tmux_show_datetime 0
            set -g @tokyo-night-tmux_show_netspeed 1
            set -g @tokyo-night-tmux_netspeed_showip 1      # Display IPv4 address (default 0)
            set -g @tokyo-night-tmux_netspeed_refresh 1     # Update interval in seconds (default 1)
            set -g @tokyo-night-tmux_show_music 1
          '';
        }
      ];
      #BUG:https://github.com/nix-community/home-manager/issues/3555
      extraConfig = builtins.readFile ../config/tmux/tmux.conf.common;
    };

    lazygit = {
      enable = true;
      settings = {
        keybinding.commits = {
          moveDownCommit = "<c-n>";
          moveUpCommit = "<c-p>";
        };
        customCommands = [
          {
            key = "Z";
            command = "git cz c";
            description = "commit with commitizen";
            context = "files";
            loadingText = "opening commitizen commit tool";
            subprocess = true;
          }
          {
            key = "E";
            description = "Add empty commit";
            context = "commits";
            command = "git commit --allow-empty -m 'empty commit'";
            loadingText = "Committing empty commit...";
          }
        ];
      };
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-notify
        gh-s
        gh-f
        gh-poi
        gh-eco
      ];
    };
    bash = {
      enable = true;
      enableCompletion = true;
      # TODO 在这里添加你的自定义 bashrc 内容
      bashrcExtra = ''
        export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      '';

      # TODO 设置一些别名方便使用，你可以根据自己的需要进行增删
      shellAliases = {
        #k = "kubectl";
        asd = "lazygit";
        e = "nvim";
        q = "exit";
        zj = "zellij";
        cdtmp = "cd $(mktemp -d)";
        update = "sudo nixos-rebuild switch --impure";
      };
    };
  };
  home.file.".npmrc" = {
    text = ''
      prefix=~/.npm-packages
      registry=https://registry.npmmirror.com
    '';
  };
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
    configFile = {
      # FIX: I don't want this plugin  slow down my valuable build time
      # "zellij/layouts/default.kdl".text = ''
      #   layout {
      #       default_tab_template {
      #           children
      #           pane size=1 borderless=true {
      #               plugin location="file:${inputs.zjstatus.packages.x86_64-linux.default}/bin/zjstatus.wasm" {
      #                   format_left   "{mode} #[fg=#89B4FA,bold]{session}"
      #                   format_center "{tabs}"
      #                   format_right  "{command_git_branch} {datetime}"
      #                   format_space  ""
      #
      #                   border_enabled  "false"
      #                   border_char     "─"
      #                   border_format   "#[fg=#FFAAFF]{char}"
      #                   border_position "top"
      #
      #                   hide_frame_for_single_pane "true"
      #
      #                   mode_normal    "#[fg=#54DB8C]{name}"
      #                   mode_tab       "#[fg=#ffc387]{name}"
      #                   mode_scroll    "#[fg=#FF5587]{name}"
      #                   mode_search    "#[fg=#AF5587]{name}"
      #                   mode_pane      "#[fg=#FF7846]{name}"
      #                   mode_locked    "#[fg=#FF0A32]{name}"
      #
      #                   tab_normal   "#[fg=#6C7086] {name} "
      #                   tab_active   "#[fg=#FF99B2,bold] {name} "
      #                   tab_sync_indicator       "<> "
      #                   tab_fullscreen_indicator "[] "
      #                   tab_floating_indicator   "⬚ "
      #
      #                   command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
      #                   command_git_branch_format      "#[fg=blue] {stdout} "
      #                   command_git_branch_interval    "10"
      #                   command_git_branch_rendermode  "static"
      #
      #                   datetime        "#[fg=#B27086,bold] {format} "
      #                   datetime_format "%A, %b %d"
      #                   datetime_timezone "Asia/Shanghai"
      #               }
      #           }
      #       }
      #   }
      # '';
      "nvim" = {
        source = mkOutOfStoreSymlink "/etc/nixos/dots/config/nvim";
      };
      "nix-extra/sqlite3.path".text = "${pkgs.sqlite.out}/lib/libsqlite3.so";
      "nushell" = {
        source = mkOutOfStoreSymlink "/etc/nixos/dots/config/nushell";
      };
      "waybar" = {
        source = mkOutOfStoreSymlink "/etc/nixos/dots/config/waybar";
      };
      "emacs/init.el" = {
        source = ../config/emacs/init.el;
      };
      "emacs/elfeed.org" = {
        source = ../config/emacs/elfeed.org;
      };
      "emacs/early-init.el" = {
        source = ../config/emacs/early-init.el;
      };
      "zellij/config.kdl".source = ../config/zellij/config.kdl;
      "guix" = {
        source = ../config/guix;
      };
      # "ags" = {
      #   source = mkOutOfStoreSymlink "/etc/nixos/dots/config/ags";
      # };
    };
  };

  home.packages =
    with pkgs;
    [
      #bilibili
      # qq
      #TODO: setup https://discourse.nixos.org/t/declare-firefox-extensions-and-settings/36265
      firefox
      # google-chrome
      # nix related
      #
    ]
    ++ shtools
    ++ tools
    ++ lsp
    ++ formatter;
}

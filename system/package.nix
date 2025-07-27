{
  pkgs,
  inputs,
  ...
}:
# let
#   pkgs-stable = import inputs.nixpkgs-stable {
#     system = "x86_64-linux";
#   };
# in
{
  #  only left must-have packages in systemPackages as it'll slow down man.generateCaches
  environment.systemPackages =
    with pkgs;
    [
      vim
      godot
      # texliveFull
      texliveSmall
      firefox
      pstree
      quickemu
      nix-output-monitor
      ffmpeg-full
      bc
      jq
      pnpm
      nodePackages.ts-node
      tree-sitter
      # nodePackages_latest.prisma
      gdb
      python313Packages.debugpy
      nodejs
      go
      # ida-free
      lldb
      # wikiman
      mitscheme
      # alacritty-graphics
      # vscode
      fzf
      # TODO: enable this
      # rich-cli
      cachix
      vivid
      mu
      chafa
      just
      typst
      tinymist
      yq
      cinny-desktop
      xdg-utils
      gnumake
      # this is super useful
      ngrok
      # cargo
      # rustup
      rust-bin.stable.latest.default
      libreoffice
      lyra-cursors
      linux-manual
      ast-grep
      man-pages
      clang
      luajit
      uiua
      # devenv
      clang-tools
      bun
      eza
      dart-sass
      yt-dlp
      gcc
      sqlite
      deno
      rizin
      cutter
      onefetch
      # mate.atril
      wget
      imagemagick
      luajitPackages.magick
      gemini-cli
      tela-circle-icon-theme
      beauty-line-icon-theme
      python3

      kdePackages.qtdeclarative
      kdePackages.krdc
      qt6Packages.qt5compat
      libsForQt5.qt5.qtgraphicaleffects
    ]
    ++ [
      # inputs.pwndbg.packages.${pkgs.system}.default
      inputs.quickshell.packages.${pkgs.system}.default
      # (inputs.quickshell.packages.${pkgs.system}.default.override {
      #   withJemalloc = true;
      #   withQtSvg = true;
      #   withWayland = true;
      #   withX11 = false;
      #   withPipewire = true;
      #   withPam = true;
      #   withHyprland = false;
      #   withI3 = false;
      # })
    ];
  programs = {
    neovim = {
      enable = true;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim-debug;
    };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/etc/nixos/dots/";
    };
    fish.enable = true;
    git = {
      enable = true;
      # config = {
      #   init = {
      #     defaultBranch = "main";
      #   };
      # };

    };
    direnv.enable = true;
    ghidra.enable = true;
    zoxide.enable = true;
    starship = {
      enable = true;
      settings = {
        hostname.ssh_symbol = "🏄 ";
        character.error_symbol = "💔";
        character.success_symbol = "👾";
      };
      presets = [
        "jetpack"
        "nerd-font-symbols"
      ];
    };
    bash = {
      completion.enable = true;
      shellAliases = {
        asd = "lazygit";
        e = "nvim";
        q = "exit";
        t = "tmux";
        cdtmp = "cd $(mktemp -d)";
      };
    };
  };

  documentation = {
    man = {
      generateCaches = false;
    };
    dev.enable = true;
  };

  # qt.enable = true;
}

{ pkgs, inputs, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
  };
in
{
  # TODO: only left must-have packages in systemPackages as it'll slow down man.generateCaches
  environment.systemPackages =
    with pkgs;
    [
      vim
      godot
      pstree
      quickemu
      nix-output-monitor
      ffmpeg-full
      bc
      jq
      # emacs
      pnpm
      nodePackages.ts-node
      tree-sitter
      # nodePackages_latest.prisma
      python312
      gdb
      python312Packages.debugpy
      nodejs
      go
      # ida-free
      lldb
      # wikiman
      mitscheme
      # alacritty-graphics
      # vscode
      fzf
      rich-cli
      cachix
      chafa
      just
      ghostty
      typst
      tinymist
      yq
      gnumake
      # this is super useful
      ngrok
      # cargo
      # rustup
      rust-bin.stable.latest.default
      libreoffice
      linux-manual
      ast-grep
      man-pages
      clang
      luajit
      uiua
      # devenv
      clang-tools
      bun
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
    ]
    ++ [
      # inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      inputs.pwndbg.packages.${pkgs.system}.default
      inputs.quickshell.packages."x86_64-linux".default
      pkgs-stable.kdePackages.qtdeclarative
    ];
  qt.enable = true;
  qt.platformTheme = "qt5ct";
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
  };
  documentation = {
    man = {
      # generateCaches = true;
    };
    dev.enable = true;
  };
}

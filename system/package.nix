{
  pkgs,
  inputs,
  ...
}:
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
      firefox_nightly
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
      rich-cli
      cachix
      chafa
      just
      typst
      tinymist
      yq
      zathura
      xdg-utils
      gnumake
      # this is super useful
      ngrok
      # cargo
      # rustup
      rust-bin.stable.latest.default
      libreoffice
      #TODO: configure it with nix
      kanagawa-gtk-theme
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
    ]
    ++ [
      inputs.pwndbg.packages.${pkgs.system}.default
      inputs.quickshell.packages.${pkgs.system}.default
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
  };
  documentation = {
    man = {
      generateCaches = false;
    };
    dev.enable = true;
  };
}

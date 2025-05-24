{ pkgs, inputs, ... }:
{
  # TODO: only left must-have packages in systemPackages as it'll slow down man.generateCaches
  environment.systemPackages =
    with pkgs;
    [
      vim
      #TODO: https://github.com/nvbn/thefuck/pull/1442
      nix-output-monitor
      ffmpeg
      bc
      jq
      # emacs
      pnpm
      nodePackages.ts-node
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
      # vscode
      fzf
      #TODO: extensions?
      cachix
      chafa
      just
      typst
      tinymist
      yq
      gnumake
      # this is super useful
      ngrok
      # cargo
      rustup
      # rust-bin.stable.latest.default
      linux-manual
      ast-grep
      man-pages
      clang
      luajit
      uiua
      devenv
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
    ]
    ++ [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      # inputs.pwndbg.packages.${pkgs.system}.default
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
      # generateCaches = true;
    };
    dev.enable = true;
  };
}

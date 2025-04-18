{ pkgs, inputs, ... }:
{
  # TODO: only left must-have packages in systemPackages as it'll slow down man.generateCaches
  environment.systemPackages =
    with pkgs;
    [
      vim
      #TODO: https://github.com/nvbn/thefuck/pull/1442
      libnotify
      tpm2-tss
      nix-output-monitor
      w3m-nox
      ffmpeg
      sbctl
      fuzzel
      qbittorrent-enhanced
      playerctl
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
      filebrowser
      go
      grim
      # ida-free
      lldb
      ddcutil
      gparted
      # wikiman
      mitscheme
      qcm
      # vscode
      fzf
      cachix
      aircrack-ng
      chafa
      cliphist
      just
      typst
      tinymist
      telegram-desktop
      yq
      gnumake
      # this is super useful
      ngrok
      # cargo
      # rustup
      # rust-bin.stable.latest.default
      linux-manual
      ast-grep
      man-pages
      clang
      luajit
      uiua
      devenv
      clang-tools
      swww
      bun
      dart-sass
      brightnessctl
      yt-dlp
      gcc
      sqlite
      wl-clipboard
      deno
      neovide
      rizin
      obs-studio
      cutter
      onefetch
      # mate.atril
      slurp
      wlsunset
      # nodePackages.vscode-html-languageserver-bin
      wget
      flameshot
      imagemagick
      luajitPackages.magick
    ]
    ++ [
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
      # inputs.pwndbg.packages.${pkgs.system}.default
    ];
  programs = {
    virt-manager.enable = true;
    neovim = {
      enable = true;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      # package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim-debug;
    };
    wireshark.enable = true;
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

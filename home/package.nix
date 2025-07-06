{
  pkgs,
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
    # TODO: not available
    # tombi
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
    typstyle
  ];
  tools = [
    cowsay
    # manix
    htop-vim
    fastfetch
    exiftool
    tealdeer
    dust
    delta
    ueberzugpp
    mpv
    lazyjj
  ];
  shtools = [
    zip
    bat
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
    ouch
    fd
    ripgrep
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    btop
    gh
    carapace
    starship
  ];
in
{
  programs = {
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
    hyprlock.enable = true;
    ghidra.enable = true;
    zoxide.enable = true;
    lazygit.enable = true;
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

  hjem.users.ring = {
    packages =
      with pkgs;
      [
        #bilibili
        # qq
        uv
        # nix related
        dconf
      ]
      ++ shtools
      ++ tools
      ++ lsp
      ++ formatter;
  };
}

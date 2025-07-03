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
    fuzzel
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
    kitty
  ];
in
{
  programs = {
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        extrakto
        vim-tmux-navigator
        kanagawa
        resurrect
        fzf-tmux-url
      ];
      extraConfig = builtins.readFile ../config/tmux/tmux.conf.common;
      extraConfigBeforePlugins = ''
        set -g @extrakto_key "f"
        set -g @kanagawa-ignore-window-colors true
        set -g @kanagawa-theme 'dragon'
        set -g @kanagawa-plugins "network-bandwidth cpu-usage ram-usage battery"
        set -g @kanagawa-show-flags true
        set -g @kanagawa-network-bandwidth-colors "pink dark_gray"
        set -g @kanagawa-battery-colors "green dark_gray"
        set -g @kanagawa-show-powerline true
        set -g @kanagawa-network-bandwidth "wlp2s0"
        set -g @kanagawa-ram-usage-label " "
        set -g @kanagawa-cpu-usage-label "󰻠 "
        set -g @kanagawa-show-edge-icons true
        set -g @kanagawa-transparent-powerline-bg true
        set -g @kanagawa-show-empty-plugins true
        set -g @kanagawa-border-contrast true
        set -g @kanagawa-show-left-icon "#h | #S"
        set -g @kanagawa-battery-label "♥ "
        set -g @kanagawa-narrow-plugins "compact-alt network-bandwidth"
      '';
    };
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
    #BUG: https://github.com/NixOS/nixpkgs/issues/380540
    # starship = {
    #   enable = true;
    #   settings = {
    #     hostname.ssh_symbol = "🏄 ";
    #   };
    #   presets = [ "jetpack" ];
    # };
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
        firefox
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

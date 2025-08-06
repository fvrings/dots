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
    awk-language-server
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
    tombi
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
    imv
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
    swww
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
    carapace
    starship
  ];
in
{

  home = {
    packages =
      with pkgs;
      [
        #bilibili
        # qq
        # nix related
        dconf

        (pkgs.writeShellScriptBin "toggle-theme" ''
          #!/bin/sh

          icon_path="${pkgs.beauty-line-icon-theme}/share/icons/BeautyLine/apps/scalable/nixos.png"

          # Read current theme or fallback to 'default'
          if [ -f /etc/specialisation ]; then
            current_theme=$(cat /etc/specialisation)
          else
            current_theme="default"
          fi

          case "$current_theme" in
            "default")
              next_theme="gruvbox-material-light-soft"
              notify="Switching to Gruvbox-Light"
              switch_cmd="/nix/var/nix/profiles/system/specialisation/$next_theme/bin/switch-to-configuration switch"
              ;;
            "gruvbox-material-light-soft")
              next_theme="catppuccin-latte"
              notify="Switching to Catppuccin-Latte"
              switch_cmd="/nix/var/nix/profiles/system/specialisation/$next_theme/bin/switch-to-configuration switch"
              ;;
            "catppuccin-latte")
              next_theme="oxocarbon-dark"
              notify="Switching to Oxocarbon-Dark"
              switch_cmd="/nix/var/nix/profiles/system/specialisation/$next_theme/bin/switch-to-configuration switch"
              ;;
            "oxocarbon-dark")
              next_theme="default"
              notify="Switching to Kanagawa-Dark"
              switch_cmd="/nix/var/nix/profiles/system/bin/switch-to-configuration switch"
              ;;
            *)
              ;;
          esac

          notify-send "$notify" -a "Theme" -i "$icon_path"
          doas $switch_cmd
          systemctl restart --user swww
          qs ipc call themeLoader reloadTheme
        '')
      ]
      ++ shtools
      ++ tools
      ++ lsp
      ++ formatter;
  };
  programs.fzf.enable = true;
}

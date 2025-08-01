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
          # get current active system configuration
          current_system=$(readlink /run/current-system)
          # get the system path for the 'light' specialisation
          light_specialisation=$(readlink /nix/var/nix/profiles/system/specialisation/light)
          # check if the current system configuration matches the 'light' specialisation
          if [ "$current_system" == "$light_specialisation" ]; then
          notify-send "Switching to Dark" -a "Theme" -i ${pkgs.beauty-line-icon-theme}/share/icons/BeautyLine/apps/scalable/nixos.png
          doas /nix/var/nix/profiles/system/bin/switch-to-configuration switch
          else
          notify-send "Switching to Light" -a "Theme" -i ${pkgs.beauty-line-icon-theme}/share/icons/BeautyLine/apps/scalable/nixos.png
          doas /nix/var/nix/profiles/system/specialisation/light/bin/switch-to-configuration switch
          fi

        '')
      ]
      ++ shtools
      ++ tools
      ++ lsp
      ++ formatter;
  };
}

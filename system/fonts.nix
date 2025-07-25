{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
          "Uiua386"
        ];

        monospace = [
          # "BlexMono Nerd Font"
          # "IBM Plex Mono"
          # "JetBrainsMonoNL Nerd Font"
          # "Maple Mono NF"
          # "LXGW WenKai Mono"
          "Iosevka"
          # "IntoneMono Nerd Font"
          # "Martian Mono"
          # "GoMono Nerd Font"
          # "Noto Color Emoji"
        ];
        sansSerif = [
          # "Noto Sans CJK HK"
          "Aporetic Sans"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
        serif = [
          # "Noto Sans CJK HK"
          "Aporetic Serif"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
      };
    };

    packages = with pkgs; [
      # nerd-fonts.go-mono
      # nerd-fonts.intone-mono
      # nerd-fonts.iosevka-term
      # nerd-fonts.comic-shanns-mono
      # martian-mono
      noto-fonts-emoji
      aporetic
      iosevka
      nerd-fonts.symbols-only
      # ibm-plex
      # intel-one-mono
      # source-serif-pro
      # source-han-sans
      # fira-code
      # noto-fonts-cjk
      # maple-mono-SC-NF
      lxgw-wenkai
      uiua386
      # noto-fonts
    ];
  };
}

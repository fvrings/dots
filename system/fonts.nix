{ pkgs, ... }:
{
  # fonts
  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [
          "Noto Color Emoji"
        ];

        monospace = [
          # "BlexMono Nerd Font"
          # "IBM Plex Mono"
          # "JetBrainsMonoNL Nerd Font"
          # "Maple Mono NF"
          # "LXGW WenKai Mono"
          "IosevkaTerm Nerd Font"
          "IntoneMono Nerd Font"
          "Martian Mono"
          "Noto Color Emoji"
          "Uiua386"
        ];
        sansSerif = [
          # "Noto Sans CJK HK"
          # "Source Serif Pro"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
        serif = [
          # "Noto Sans CJK HK"
          # "Source Serif Pro"
          "LXGW WenKai"
          # "Source Han Sans SC"
          # "Noto Color Emoji"
        ];
      };
    };

    packages = with pkgs; [
      nerd-fonts.intone-mono
      nerd-fonts.iosevka-term
      nerd-fonts.comic-shanns-mono
      martian-mono
      noto-fonts-emoji
      # ibm-plex
      # intel-one-mono
      # source-serif-pro
      # source-han-sans
      fira-code
      # noto-fonts-cjk
      # maple-mono-SC-NF
      lxgw-wenkai
      uiua386
      noto-fonts
    ];
  };
}

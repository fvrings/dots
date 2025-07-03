{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    google-chrome
    wechat-uos
    libnotify
    tpm2-tss
    w3m-nox
    sbctl
    qbittorrent-enhanced
    playerctl
    filebrowser
    ddcutil
    gparted
    qcm
    virt-viewer
    aircrack-ng
    cliphist
    telegram-desktop
    code-cursor
    brightnessctl
    wl-clipboard
    neovide
    obs-studio
    wlsunset
    flameshot
  ];
  programs = {
    virt-manager.enable = true;
    wireshark.enable = true;
  };
}

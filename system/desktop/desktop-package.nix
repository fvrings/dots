{ pkgs, inputs, ... }:
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
    grim
    ddcutil
    gparted
    qcm
    virt-viewer
    ghidra-bin
    aircrack-ng
    cliphist
    telegram-desktop
    code-cursor
    brightnessctl
    wl-clipboard
    neovide
    obs-studio
    slurp
    wlsunset
    flameshot
  ];
  programs = {
    virt-manager.enable = true;
    wireshark.enable = true;
  };
}

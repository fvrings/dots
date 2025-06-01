{ pkgs, ... }:
{
  services = {
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    cheese
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    totem # video player
    gnome-music
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    xterm
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.kimpanel
    gnomeExtensions.ideapad
  ];
}

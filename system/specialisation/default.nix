{
  imports = [
    ./gruvbox-material-light-soft.nix
    ./oxocarbon-dark.nix
    ./catppuccin-latte.nix
  ];
  environment.etc."theme-config.qml".text = ''
    import QtQuick

    QtObject {
        readonly property color backgroundColor: "transparent"
    }
  '';
}

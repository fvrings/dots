{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.fuzzel ];
    file = {
      ".config/fuzzel/fuzzel.ini".text = ''
        include=~/.config/fuzzel/matugen.ini
        terminal=ghostty
        prompt=">>  "
        layer=overlay

        [border]
        radius=17
        width=1

        [dmenu]
        exit-immediately-if-empty=yes
      '';
    };
  };
}

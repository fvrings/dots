{ pkgs, ... }:
{
  hjem.users.ring = {
    packages = [ pkgs.kitty ];
    files = {
      ".config/kitty/kitty.conf".text =
        (builtins.readFile ../../../config/kitty/kitty.conf)
        + ''
          include ${pkgs.kitty-themes}/share/kitty-themes/themes/kanagawa_dragon.conf
          include matugen.conf
        '';
    };
  };
}

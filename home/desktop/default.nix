_: {
  home-manager = {
    users.ring.imports = [
      ./bg-utils
      ./theme.nix
      ./wallpaper.nix
      ./waybar.nix
    ];
  };
}

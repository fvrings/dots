_: {
  home-manager = {
    users.ring.imports = [
      ./bg-utils
      ./theme.nix
      ./waybar.nix
    ];
  };
}

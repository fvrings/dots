{ inputs, osConfig, ... }:
{
  # home-manager.users.ring = import ./home.nix {inherit inputs lib pkgs;};
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.ring.imports = [
      ./ring.nix
      ./devtools.nix
      ./yazi.nix
      inputs.nix-index-database.hmModules.nix-index
      inputs.ags.homeManagerModules.default
      inputs.catppuccin.homeManagerModules.catppuccin
    ] ++ (if osConfig.networking.hostName == "art" then [ ./desktop ] else [ ]);
    extraSpecialArgs = { inherit inputs; };
  };
}

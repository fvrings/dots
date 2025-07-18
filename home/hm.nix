{ lib, inputs, ... }:
let
  # Function to get all subdirectories in a given path
  # path: The directory path to scan (e.g., ./. for the current directory)
  getDirsInPath =
    path:
    let
      # Read the contents of the directory
      dirContents = builtins.readDir path;
      # Filter out only the directories
      directories = lib.filterAttrs (_name: type: type == "directory") dirContents;
      # Get the names of these directories
      dirNames = lib.attrNames directories;
    in
    # Map each directory name to its full path relative to the current file
    lib.map (name: path + "/${name}") dirNames;

  # Call the function for the current directory
  # The '.' refers to the directory where this Nix file is located
  currentFolderDirs = getDirsInPath ./.;
  modules = [
    inputs.maomaowm.hmModules.maomaowm
    inputs.self.nixosModules.theme
  ];
in
{
  imports =
    [
      ./package.nix
      ./theme.nix
    ]
    ++ currentFolderDirs
    ++ modules;

  stylix.targets.niri.enable = false;
  stylix.targets.emacs.enable = false;
  home = {
    username = "ring";
    homeDirectory = "/home/ring";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.

    stateVersion = "25.05";
  };

}

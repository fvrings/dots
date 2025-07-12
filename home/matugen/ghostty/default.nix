{ pkgs, inputs, ... }:
{
  home = {
    packages = [
      #TODO: https://github.com/ghostty-org/ghostty/discussions/7356
      # inputs.ghostty.packages.${pkgs.system}.default
      pkgs.ghostty
    ];
    file = {
      ".config/ghostty/config".source = ./config;
    };
  };
}

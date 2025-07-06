{ pkgs, inputs, ... }:
{
  hjem.users.ring = {
    packages = [
      #TODO: https://github.com/ghostty-org/ghostty/discussions/7356
      inputs.ghostty.packages.${pkgs.system}.default
    ];
    files = {
      ".config/ghostty/config".source = ./config;
    };
  };
}

{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs.black.enable = true;
      programs.nixfmt.enable = true;
      programs.biome = {
        enable = true;
        excludes = [
          "*.yaml"
          "*.lock"
          "config/**/lazy-lock.json"
          "*.yml"
          "config/**/vs-snippets/*"
        ];
        settings.formatter = {
          indentStyle = "space";
          indentWidth = 2;
        };
      };
      programs.stylua.enable = true;
      programs.shfmt = {
        enable = true;
        indent_size = 0;
      };
    };
  };
}

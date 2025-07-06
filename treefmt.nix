{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt.config = {
      projectRootFile = "flake.nix";
      programs = {
        black.enable = true;
        nixfmt.enable = true;
        qmlformat.enable = true;
        biome = {
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
        stylua.enable = true;
        shfmt = {
          enable = true;
          indent_size = 2;
        };
      };
    };
  };
}

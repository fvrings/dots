{ lib, ... }:
{
  options.theme = {
    wallpaper = lib.mkOption {
      description = ''
        Location of the wallpaper to use throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExample "./wallpaper.png";
    };
    wallpaper-light = lib.mkOption {
      description = ''
        Location of the wallpaper to use throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExample "./wallpaper.png";
    };
    wallpaper-anime = lib.mkOption {
      description = ''
        Location of the wallpaper to use throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExample "./wallpaper.png";
    };

    wallpaper-universe = lib.mkOption {
      description = ''
        Location of the wallpaper to use throughout the system.
      '';
      type = lib.types.path;
      example = lib.literalExample "./wallpaper.png";
    };
    shell = lib.mkOption {
      description = ''
        shell of your choice
      '';
      type = lib.types.str;
      example = lib.literalExample "qs";
    };
    dwl = lib.mkEnableOption "dwl";
  };
}

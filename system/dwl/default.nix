#NOTE: LESS IS MORE
{
  pkgs,
  config,
  ...
}:
let
  dwl' = pkgs.callPackage ./pkg.nix { };

  dwlWrapper = pkgs.writeScript "dwl-wrapper" ''
    #!/usr/bin/env bash

    # Ensure bar.sh runs and feeds stdin into dwl
    exec ${./bar.sh} | ${dwl'}/bin/dwl -s "${pkgs.swaybg}/bin/swaybg -i ${config.theme.wallpaper-light}"
  '';
  dwlSession = pkgs.stdenv.mkDerivation {
    pname = "dwl-session";

    version = "1.0";

    buildCommand = ''
      mkdir -p $out/share/wayland-sessions
      cp ${
        pkgs.makeDesktopItem {
          name = "dwl";
          desktopName = "Dwl";
          exec = "${dwlWrapper}";
          comment = "DWM for Wayland";
        }
      }/share/applications/dwl.desktop $out/share/wayland-sessions/dwl.desktop
    '';

    passthru.providedSessions = [ "dwl" ];
  };
in
{
  services.displayManager.sessionPackages = [ dwlSession ];
  environment.systemPackages = [
    pkgs.wmenu
    dwl'
  ];
}

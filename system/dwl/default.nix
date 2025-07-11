#NOTE: LESS IS MORE
{
  pkgs,
  lib,
  config,
  ...
}:
let
  # TODO: move this to flake ?
  patch-repo = builtins.fetchGit {
    url = "https://codeberg.org/dwl/dwl-patches";
    rev = "49aba1d42b52d5388f1a1d524f4b58dddd8295ba";
  };

  follow-origin = builtins.readFile "${patch-repo}/patches/follow/follow.patch";
  follow' = builtins.replaceStrings [ "printstatus" ] [ "drawbars" ] follow-origin;
  follow-patch = pkgs.writeText "follow.patch" follow';

  gaps-origin = builtins.readFile "${patch-repo}/patches/gaps/gaps.patch";

  stringToInsert = " static const int follow                    = 1;  /* 1 means follow windows when sent to another tag */";
  lineNumber = 23; # 1-indexed

  # Split the content into a list of lines
  lines = lib.splitString "\n" gaps-origin;

  # Insert the string at the desired line number
  # We need to handle 0-indexing for lists vs. 1-indexing for line numbers
  modifiedLines =
    (lib.take (lineNumber - 1) lines) ++ [ stringToInsert ] ++ (lib.drop (lineNumber - 1) lines);

  # Join the lines back into a single string
  gaps' = lib.concatStringsSep "\n" modifiedLines;
  gaps-patch = pkgs.writeText "gaps.patch" gaps';

  patches = [
    "${patch-repo}/patches/bar/bar-0.7.patch"
    follow-patch
    gaps-patch
    "${patch-repo}/patches/menu/menu.patch"
    "${patch-repo}/patches/sticky/sticky.patch"
  ];
  dwl' = pkgs.dwl.overrideAttrs (
    _finalAttrs: previousAttrs: {
      inherit patches;
      buildInputs =
        previousAttrs.buildInputs
        ++ (with pkgs; [
          fcft
          libdrm
        ]);
      postPatch =
        let
          configFile = ./dwl-config.h;
        in
        ''
          cp ${configFile} config.def.h
        '';
    }
  );

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

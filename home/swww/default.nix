{
  pkgs,
  config,
  ...
}:

let
  swww-daemon = "swww-daemon.service";
  graphical = config.wayland.systemd.target;

in

{
  # services.swww.enable = true;
  systemd.user = {
    services.swww = {

      Unit = {
        Description = "swww image setter";
        After = [ swww-daemon ];
        Requires = [ swww-daemon ];
      };

      Install = {
        WantedBy = [ swww-daemon ];
      };

      Service = {
        ExecStart = "${pkgs.swww}/bin/swww img --transition-type random --transition-fps 60 --transition-duration 2 ${config.theme.wallpaper-universe}";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
    services.swww-daemon = {

      Unit = {
        Description = "swww-daemon";
        After = [ graphical ];
        PartOf = [ graphical ];
      };

      Install = {
        WantedBy = [ graphical ];
      };

      Service = {
        # Environment = "WAYLAND_DISPLAY=wayland-0";
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
        RestartSec = 1;
      };
    };
  };
}

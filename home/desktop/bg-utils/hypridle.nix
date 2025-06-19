{
  lib,
  config,
  pkgs,
  ...
}:
let
  timeout = 300;
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = lib.getExe config.programs.hyprlock.package;
        before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      };
      listener = [
        {
          timeout = timeout / 3;
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = timeout - 5;
          on-timeout = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          inherit timeout;
          on-timeout = "${lib.getExe config.programs.hyprlock.package}";
        }
        {
          timeout = timeout * 2;
          on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors";
        }
        {
          timeout = timeout * 6;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}

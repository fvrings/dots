{
  lib,
  config,
  pkgs,
  ...
}:
let
  timeout = 300;
  settings = ''
    general  {
      lock_cmd = lib.getExe config.programs.hyprlock.package;
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
    }
    listener {
        timeout = ${builtins.toString (timeout / 3)};
        on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
        on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
    }
    listener {
        timeout = ${builtins.toString (timeout - 5)};
        on-timeout = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
    }
    listener {
        inherit ${builtins.toString timeout};
        on-timeout = "${lib.getExe config.programs.hyprlock.package}";
    }
    listener {
        timeout = ${builtins.toString (timeout * 2)};
        on-timeout = "${pkgs.niri}/bin/niri msg action power-off-monitors";
    }
    # listener {
    #   timeout = ${builtins.toString (timeout * 6)};
    #   on-timeout = "systemctl suspend";
    # }'';
in
{
  services.hypridle = {
    enable = true;
  };
  hjem.users.ring.files = {
    ".config/hypr/hypridle.conf".text = settings;
  };
}

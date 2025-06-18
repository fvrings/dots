_: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar-style.css;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        spacing = 4;
        height = 30;
        margin = "8px 8px 0";
        modules-left = [
          "custom/heart"
          "niri/workspaces"
        ];
        modules-right = [
          "network"
          "cpu"
          "memory"
          "pulseaudio"
          "backlight"
          "battery"
          "clock"
          "tray"
        ];
        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };
        "niri/workspaces" = {
          "all-outputs" = true;
          "format" = "{icon}";
          "format-icons" = {
            "1" = "壹";
            "2" = "贰";
            "3" = "叁";
            "4" = "肆";
            "5" = "伍";
          };
        };

        "custom/heart" = {
          "format" = "";
          "on-click" = "systemctl hibernate";
        };
        "clock" = {
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = "{usage}% 󰻠";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{}% 󰍛";
        };
        "backlight" = {
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "battery" = {
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-full" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% 󰂄";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "network" = {
          "format-wifi" = "{bandwidthUpBytes} 󰕒 {bandwidthDownBytes} 󰇚";
          "interval" = 1;
          "format-ethernet" = "{bandwidthUpBytes} 󰕒 {bandwidthDownBytes} 󰇚";
          "format-disconnected" = "Disconnected 󱘖";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-bluetooth-muted" = "󰂲 {icon} {format_source}";
          "format-muted" = "󰖁 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
      };
    };
  };
}

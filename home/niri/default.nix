{

  imports = [
    ./binds.nix
  ];
  programs.niri.settings = {
    input = {
      keyboard.xkb.options = "caps:swapescape";
      touchpad = {
        tap = true;
        dwt = true;
        dwtp = true;
        natural-scroll = true;
        accel-speed = -0.2;
        scroll-method = "two-finger";
      };
    };

    layout = {
      gaps = 10;
      tab-indicator = {
        width = 2;
        gap = 8;
        length = {
          total-proportion = 0.96;
        };
        position = "top";
        place-within-column = true;
        inactive.color = "#0F4532";
        active.color = "#6666cc";
      };

      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = {
        proportion = 0.5;
      };

      focus-ring = {
        width = 1;
        inactive.color = "#61202d";
        active.color = "#d2788a";
      };

      border = {
        enable = true;
        width = 4;
        active.color = "#ffc87f";
        inactive.color = "#505050";
      };

      struts = { };
    };

    spawn-at-startup = [
      {
        command = [
          "xwayland-satellite"
        ];
      }
      {
        command = [
          "fcitx5"
          "-d"
        ];
      }
      {
        command = [
          "wl-paste"
          "--watch"
          "cliphist"
          "store"
        ];
      }
      {
        command = [
          "wlsunset"
          "-l"
          "39.9"
          "-L"
          "116.3"
        ];
      }
      { command = [ "quickshell" ]; }
    ];

    environment = {
      QT_QPA_PLATFORM = "wayland";
    };

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    animations = {
      enable = true;
      slowdown = 1.0;
      workspace-switch.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 1000;
        epsilon = 0.0001;
      };
      # window-open = {
      #   duration-ms = 150;
      #   curve = "ease-out-quad";
      # };
      # window-close = {
      #   duration-ms = 150;
      #   curve = "ease-out-quad";
      # };
      horizontal-view-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
      window-movement.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
      window-resize.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
      config-notification-open-close.kind.spring = {
        damping-ratio = 0.6;
        stiffness = 1000;
        epsilon = 0.001;
      };
      # screenshot-ui-open = {
      #   duration-ms = 200;
      #   curve = "ease-out-quad";
      # };
      overview-open-close.kind.spring = {
        damping-ratio = 1.0;
        stiffness = 800;
        epsilon = 0.0001;
      };
    };

    window-rules = [
      {
        matches = [ { app-id = "firefox"; } ];
        default-column-display = "tabbed";
        open-maximized = true;
      }
      {
        matches = [
          { app-id = "firefox"; }
          { title = "^Picture-in-Picture$"; }
        ];
        open-floating = true;
      }
      {
        geometry-corner-radius = {
          bottom-left = 9.0;
          bottom-right = 9.0;
          top-right = 9.0;
          top-left = 9.0;
        };
        clip-to-geometry = true;
      }
    ];

    outputs = {
      "eDP-1" = {
        scale = 1.5;
        variable-refresh-rate = "on-demand";
        focus-at-startup = true;
      };
    };
  };
}

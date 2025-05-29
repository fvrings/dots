{
  inputs,
  pkgs,
  config,
  ...
}:
let
  swww = "swww.service";
in
{
  programs.fuzzel.enable = true;
  services.swww.enable = true;
  systemd.user.services.swww-img = {
    Install = {
      WantedBy = [ swww ];
    };

    Unit = {
      Description = "swww-img";
      After = [ swww ];
      PartOf = [ swww ];
    };

    Service = {
      ExecStart = "swww img ${config.theme.wallpaper}";
      Restart = "always";
      RestartSec = 10;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
      # inputs.hypr-darkwindow.packages.${pkgs.system}.Hypr-DarkWindow
      # inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #TODO:add a music mode?
    extraConfig = ''
      bind=$mod SHIFT,r,submap,resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,l,resizeactive,10 0
      binde=,h,resizeactive,-10 0
      binde=,k,resizeactive,0 -10
      binde=,j,resizeactive,0 10

      # use reset to go back to the global submap
      bind=,escape,submap,reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # will switch to a submap called move
      bind=$mod shift,m,submap,move

      # will start a submap called "move"
      submap=move
      bind=,escape,submap,reset

      # sets repeatable binds for moving the active window
      bind=,l,movewindow,r
      bind=,h,movewindow,l
      bind=,k,movewindow,u
      bind=,j,movewindow,d

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # will switch to a submap called opacity
      bind=$mod shift,o,submap,opacity

      # will start a submap called "move"
      submap=opacity
      bind=,escape,submap,reset

      # sets repeatable binds for moving the active window
      bind=,j,exec,~/.config/hypr/scripts/opacity.py d
      bind=,k,exec,~/.config/hypr/scripts/opacity.py i

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

    '';
    settings = {
      "$mod" = "SUPER";
      monitor = [
        ",preferred,0x0,1.5"
      ];
      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"
      ];
      bind = [
        "$mod,W,exec,ghostty"
        # "$mod,grave,hyprexpo:expo,toggle"
        # "$mod,B,invertactivewindow"
        "$mod,Return,exec,alacritty --class termfloat"
        "$mod,F,exec,firefox"
        # "$mod,S,exec,ags -t panel"
        "$mod,S,exec,grim -g $(slurp)"
        "$mod SHIFT,P,exec,hyprpicker -a"
        "$mod,X,exec,playerctl -p Qcm play-pause"
        "$mod,N,exec,playerctl -p Qcm next"
        # "$mod,R,exec,ags -t launcher"
        "$mod,R,exec,fuzzel"
        "$mod,Y,exec,ghostty -e yazi"
        "$mod SHIFT,R,exec,rofi -show run"
        "$mod,A,fullscreen"
        "$mod,Q,killactive"
        "$mod,P,exec,cliphist list | fuzzel --dmenu| cliphist decode | wl-copy"
        #TODO: work with ags
        "$mod,C, movetoworkspace, special"
        "$mod,TAB, togglespecialworkspace"
        "$mod,O,exec,~/.config/hypr/scripts/toggle.sh"
        "$mod,I,exec,~/.config/hypr/scripts/scale.sh"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
        "$mod SHIFT,BACKSPACE,exit"
        "$mod SHIFT,F,togglefloating"
        "$mod SHIFT,P,exec,hyprlock"
        "$mod SHIFT,H,workspace,-1"
        "$mod SHIFT,L,workspace,+1"
        "$mod,T,togglegroup"
        "$mod SHIFT,K,changegroupactive,f"
        "$mod SHIFT,J,changegroupactive,b"
        "ALT,TAB,changegroupactive,b"
        "CTRL SHIFT,h,resizeactive,-20 0"
        "CTRL SHIFT,l,resizeactive,20 0"
        "CTRL SHIFT,j,resizeactive,0 20"
        "CTRL SHIFT,k,resizeactive,0 -20"
        "$mod SHIFT,a,workspace,1"
        "$mod SHIFT,s,workspace,2"
        "$mod SHIFT,d,workspace,3"
        "$mod SHIFT,c,workspace,4"
        "$mod SHIFT,x,workspace,5"
        "$mod,1,workspace,1"
        "$mod,2,workspace,2"
        "$mod,3,workspace,3"
        "$mod,4,workspace,4"
        "$mod,5,workspace,5"
        "$mod,6,workspace,6"
        "$mod,7,workspace,7"
        "$mod,8,workspace,8"
        "$mod,9,workspace,9"
        "$mod,0,workspace,10"
        "CTRL SHIFT,1,movetoworkspace,1"
        "CTRL SHIFT,2,movetoworkspace,2"
        "CTRL SHIFT,3,movetoworkspace,3"
        "CTRL SHIFT,4,movetoworkspace,4"
        "CTRL SHIFT,5,movetoworkspace,5"
        "CTRL SHIFT,6,movetoworkspace,6"
        "CTRL SHIFT,7,movetoworkspace,7"
        "CTRL SHIFT,8,movetoworkspace,8"
        "CTRL SHIFT,9,movetoworkspace,9"
        "CTRL SHIFT,0,movetoworkspace,10"
      ];

      input = {
        kb_options = "caps:swapescape";
        follow_mouse = 1;
        # sensitivity = 1;
        touchpad = {
          natural_scroll = 1;
          scroll_factor = 0.18;
        };
      };
      xwayland = {
        force_zero_scaling = true;
      };

      master = {
        new_on_top = true;
        new_status = "master";
        orientation = "right";
        special_scale_factor = 0.8;
      };

      group = {
        "col.border_active" = "rgb(0F4532)";
        "col.border_inactive" = "rgb(6666cc)";
        groupbar = {
          "col.active" = "rgba(9999eeee)";
          "col.inactive" = "rgba(00000088)";
          render_titles = false;
          height = 1;
        };
      };

      decoration = {
        rounding = 2;
        active_opacity = 0.9;
        inactive_opacity = 0.5;
        blur = {
          enabled = true;
          size = 30;
          passes = 1;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 4;
          ignore_window = true;
        };
        dim_inactive = true;
        dim_strength = 0.3;
      };

      animations = {
        enabled = true;
        # bezier=idk,0.14,0.33,0.14,0.83
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "border,1,10,default"
          "fade,1,10,default"
          "workspaces,1,6,default"
        ];
        # animation=windows,1,3,idk
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 250;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = false;
      };

      misc = {
        disable_hyprland_logo = true;
        enable_swallow = true;
        swallow_regex = "^(Alacritty|bilibili|google-chrome|foot)$";
        focus_on_activate = true;
      };
      windowrule = [
        "float,class:termfloat"
        "size 960 540,class:termfloat"
        "rounding 20,class:termfloat"
        "float,title:polkit-kde-authentication-agent-1"
        "dimaround,title:xdg-desktop-portal-gtk"
        "dimaround,title:polkit-gnome-authentication-agent-1"
        "opacity 1.0 override 1.0 override,class:firefox"
        "opacity 1.0 override 1.0 override,class:virt-manager"
        "opacity 1.0 override 1.0 override,class:google-chrome"
        "opacity 1.0 override 1.0 override,class:bilibili"
        "opacity 0.9 override 0.9 override,class:Qcm"
        "tile,class:Qcm"
        "group,class:firefox"
        "group,class:bilibili"
        "nodim,class:mpv"
        "nodim,class:firefox"
        "nodim,class:google-chrome"
        "workspace special,class:Qcm"
        "fullscreen,class:mpv"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 15;
        border_size = 2;
        "col.inactive_border" = "rgb(313244)";
        "col.active_border" = "rgb(6666cc)";
        resize_on_border = true;
        layout = "master";
      };
      exec-once = [
        "fcitx5"
        # "ags"
        "wl-paste --watch cliphist store"
        "wlsunset -l 39.9 -L 116.3"
        # enable this all the time
        # "wlsunset -S 6:00 6:01"
      ];
      env = [
        "XDG_SESSION_TYPE,wayland"
        "GDK_SCALE,2"
        "XCURSOR_SIZE,32"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "WLR_NO_HARDWARE_CURSORS,1"
        "NVD_BACKEND,direct"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,38"
        "XMODIFIERS,fcitx"
        "QT_IM_MODULE=fcitx,fcitx"
      ];
    };
  };
}

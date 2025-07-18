{ config, ... }:
{

  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;
    "Mod+W".action = spawn [ "alacritty" ];
    "Mod+Return".action = spawn [ "kitty" ];
    "Mod+P".action = spawn [ "fuzzel" ];
    "Mod+Ctrl+L".action = spawn [ "hyprlock" ];
    "Mod+Backslash".action = spawn [
      "nu"
      "-c"
      "cliphist list | fuzzel --dmenu -w 120 | cliphist decode | wl-copy"
    ];
    "Mod+Shift+P".action = spawn [
      "qs"
      "ipc"
      "call"
      "panel"
      "fire"
    ];

    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action = spawn [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1+"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action = spawn [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1-"
      ];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action = spawn [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action = spawn [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
    };

    "Mod+Q".action = close-window;

    "Mod+H".action = focus-column-left;
    "Mod+S".action = screenshot;
    "Mod+J".action = focus-window-down-or-top;
    "ALT+TAB".action = focus-window-down-or-top;
    "Mod+K".action = focus-window-up-or-bottom;
    "Mod+L".action = focus-column-right;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+J".action = move-window-down;
    "Mod+Shift+K".action = move-window-up;
    "Mod+Shift+L".action = move-column-right;

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;

    #NOTE: https://github.com/sodiboo/niri-flake/issues/1018
    # "Mod+Ctrl+1".action = move-window-to-workspace 1;
    # "Mod+Ctrl+2".action = move-window-to-workspace 2;
    # "Mod+Ctrl+3".action = move-window-to-workspace 3;

    "Mod+X".action = consume-window-into-column;
    "Mod+Shift+X".action = expel-window-from-column;
    "Mod+D".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Ctrl+R".action = reset-window-height;
    "Mod+A".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+C".action = center-column;
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";
    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
    "Mod+Shift+BACKSPACE".action = quit;
  };
}

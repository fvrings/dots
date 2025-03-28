{ pkgs, ... }: {
  programs.niri = {
    enable = true;
    # config = builtins.readFile ./config.kdl;
    settings.binds = {
      "XF86AudioRaiseVolume".action.spawn =
        [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
      "XF86AudioLowerVolume".action.spawn =
        [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
    };
  };
}

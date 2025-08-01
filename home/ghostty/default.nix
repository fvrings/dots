{ pkgs, inputs, ... }:
{
  # home = {
  #   packages = [
  #     #TODO: https://github.com/ghostty-org/ghostty/discussions/7356
  #     # inputs.ghostty.packages.${pkgs.system}.default
  #     pkgs.ghostty
  #   ];
  #   file = {
  #     ".config/ghostty/config".source = ./config;
  #   };
  # };

  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "ctrl+enter=unbind"
        "f10=toggle_fullscreen"
        "unconsumed:alt+k=goto_split:up"
        "unconsumed:alt+j=goto_split:down"
        "unconsumed:alt+l=goto_split:right"
        "unconsumed:alt+h=goto_split:left"
        "alt+w=new_tab"
        "alt+q=close_tab"
        "alt+shift+h=new_split:left"
        "alt+shift+j=new_split:down"
        "alt+shift+k=new_split:up"
        "alt+shift+l=new_split:right"
        "alt+shift+f=toggle_split_zoom"
        "alt+n=next_tab"
        "alt+p=previous_tab"
      ];
      window-decoration = false;
      gtk-single-instance = true;
      gtk-titlebar = false;
      quit-after-last-window-closed = false;
    };
  };
}

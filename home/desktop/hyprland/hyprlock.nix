{ config, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      background = [
        {
          path = config.theme.wallpaper;
        }
      ];
      # general = {
      #   no_fade_in = false;
      #   grace = 0;
      #   disable_loading_bar = true;
      # };
      # input-field = [
      #   {
      #     outline_thickness = 2;
      #     outer_color = "rgb(f5c2e7)";
      #     inner_color = "rgb(1e1e2e)";
      #     font_color = "rgb(cdd6f4)";
      #     placeholder_text = ''
      #       <span foreground="##cdd6f4">Password...</span>
      #     '';
      #     fade_on_empty = false;
      #     dots_spacing = 0.3;
      #     dots_center = true;
      #   }
      # ];
      # label = [
      #   {
      #     text = "Hi, $USER";
      #     color = "rgb(B5462D)";
      #     valign = "center";
      #     halign = "center";
      #     font_size = 70;
      #     position = "0, 250";
      #   }
      # {
      #   text = "$TIME";
      #   color = "rgb(B5462D)";
      #   font_size = 50;
      #   position = "0, 100";
      #   valign = "center";
      #   halign = "center";
      # }
      # ];
    };
  };
}

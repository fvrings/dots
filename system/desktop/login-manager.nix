{ pkgs, ... }:
{

  services = {
    gvfs.enable = true;
    displayManager = {
      ly = {
        enable = true;
        package = pkgs.ly.overrideAttrs (
          #TODO:remove this after 1.1.2
          _: _: {
            version = "master";
            src = pkgs.fetchFromGitea {
              domain = "codeberg.org";
              owner = "fairyglade";
              repo = "ly";
              rev = "1d4e32ba82829038b58c0b01904eb5ab6ad331df";
              hash = "sha256-hxTV7uifHNMWNs2+brYZe5XnwuEIYrJVDkDWHEFVyUI=";
            };
          }
        );
        settings = {
          load = true;
          save = false;
          animation = "colormix";
          bigclock = "en";
          blank_box = false;
          clock = "%Y %a %b %d %X";
          xinitrc = "null";
          session_log = ".cache/ly-session.log";
          clear_password = true;
        };
      };
    };
  };

}

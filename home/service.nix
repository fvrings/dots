{
  pkgs,
  config,
  ...
}:

let
  user = "ring";
  swww = "swww.service";
  graphical = "niri.service";
  symLink = config: "L+ /home/${user}/.config/${config} - - - - /etc/nixos/dots/config/${config}";

in

{
  systemd.user = {
    services.swww-img = {
      enable = true;
      wantedBy = [ swww ];

      description = "swww image setter";
      after = [ swww ];
      requires = [ swww ];

      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww img ${config.theme.wallpaper}";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
    services.swww = {
      enable = true;
      wantedBy = [ graphical ];

      description = "swww-daemon";
      after = [ graphical ];
      partOf = [ graphical ];

      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
        RestartSec = 1;
      };
    };
    tmpfiles.users.ring.rules = [
      (symLink "nushell")
      (symLink "niri")
      (symLink "nvim")
      (symLink "emacs")
    ];
  };

  # services.emacs.enable = true;
  # services.xserver.windowManager.exwm.enable = true;
  # services.emacs.package = pkgs.emacs-pgtk;
}

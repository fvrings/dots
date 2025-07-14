_:

let
  user = "ring";
  symLink = config: "L+ /home/${user}/.config/${config} - - - - /etc/nixos/dots/config/${config}";

in

{
  systemd.user = {
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

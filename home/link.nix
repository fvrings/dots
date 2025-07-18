let
  user = "ring";
  symLink = config: "L+ /home/${user}/.config/${config} - - - - /etc/nixos/dots/config/${config}";

in

{
  systemd.user = {
    tmpfiles.users.ring.rules = [
      (symLink "nushell")
      (symLink "nvim")
      (symLink "emacs")
    ];
  };

}

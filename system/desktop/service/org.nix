{ pkgs, ... }:
{
  systemd.user.timers."org-notify" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "minutely";
      Persistent = "true";
      Unit = "org-notify.service";
    };
  };

  systemd.user.services."org-notify" = {
    script = ''
      set -eu
      ${pkgs.neovim}/bin/nvim -u NONE --noplugin --headless -c 'lua require("org")'
    '';
    # serviceConfig = {
    #   Type = "oneshot";
    # };
  };
}

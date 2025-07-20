{
  pkgs,
  ...
}:
{
  programs = {
    tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        {
          plugin = extrakto;
          extraConfig = ''
            set -g @extrakto_key "f"
          '';
        }
        vim-tmux-navigator
        {
          plugin = kanagawa;
          extraConfig = ''
            set -g @kanagawa-ignore-window-colors true
            set -g @kanagawa-theme 'dragon'
            set -g @kanagawa-plugins "network-bandwidth cpu-usage ram-usage battery"
            set -g @kanagawa-show-flags true
            set -g @kanagawa-network-bandwidth-colors "pink dark_gray"
            set -g @kanagawa-battery-colors "green dark_gray"
            set -g @kanagawa-show-powerline true
            set -g @kanagawa-network-bandwidth "wlp2s0"
            set -g @kanagawa-ram-usage-label " "
            set -g @kanagawa-cpu-usage-label "󰻠 "
            set -g @kanagawa-show-edge-icons true
            set -g @kanagawa-transparent-powerline-bg true
            set -g @kanagawa-show-empty-plugins true
            set -g @kanagawa-border-contrast true
            set -g @kanagawa-show-left-icon "#h | #S"
            set -g @kanagawa-battery-label "♥ "
            set -g @kanagawa-narrow-plugins "compact-alt network-bandwidth"

          '';
        }
        resurrect
        fzf-tmux-url
      ];
      extraConfig = (builtins.readFile ./tmux.conf.common) + ''
        bind-key -n M-q run-shell "${./tmux-or-nvim-kill.sh}"
      '';
    };
  };
}

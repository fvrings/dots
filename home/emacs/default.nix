{ pkgs, ... }:
{
  services = {
    emacs.enable = true;
    # xserver.windowManager.exwm.enable = true;
    emacs.package = pkgs.emacs-pgtk;
  };
  # programs.emacs.extraPackages = epkgs: [ epkgs.mu4e ];
}

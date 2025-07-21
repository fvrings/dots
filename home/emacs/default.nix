{ pkgs, ... }:
{
  services = {
    emacs.enable = true;
    # xserver.windowManager.exwm.enable = true;
    emacs.package = pkgs.emacs-pgtk;
  };
  programs.emacs = {
    enable = true;
    #TODO: I'm not going to use this ATM as it requires phone number for gmail
    extraPackages = epkgs: [ epkgs.mu4e ];
  };
  home.packages = with pkgs; [
    neomutt
    mutt-wizard
    isync
    msmtp
    pass
  ];
}

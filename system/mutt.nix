{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neomutt
    pass
    mutt-wizard
    isync
    msmtp
    gettext
  ];
}

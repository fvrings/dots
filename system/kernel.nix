{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelModules = [ "tcp_bbr" ];
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

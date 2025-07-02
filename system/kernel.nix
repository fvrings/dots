{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    # kernelModules = [ "tcp_bbr" ];
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

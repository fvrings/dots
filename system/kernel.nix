{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelModules = [ "tcp_bbr" ];
  };
  services.scx.enable = true;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

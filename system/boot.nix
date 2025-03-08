{ pkgs, ... }:
{
  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_bbr" ];
  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

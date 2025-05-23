{ pkgs, ... }:
{
  boot = {
    initrd.systemd.enable = true;
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "2";
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

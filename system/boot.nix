{ pkgs, lib, ... }:
{
  boot = {
    tmp.useTmpfs = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkForce false;
        configurationLimit = 5;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "tcp_bbr" ];
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

  };
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

{ pkgs, lib, ... }:
{
  boot = {
    initrd.systemd.enable = true;
    tmp.useTmpfs = true;
    kernelParams = [ "microcode.amd_sha_check=off" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkForce false;
        # enable = true;
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

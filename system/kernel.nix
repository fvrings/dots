{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos-lto.cachyOverride {
      mArch = "ZEN4";
    };
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelModules = [ "tcp_bbr" ];
  };
  chaotic.mesa-git.enable = true;
  services.scx.enable = true;
  services.scx.package = pkgs.scx_git.full;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}

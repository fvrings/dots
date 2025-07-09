{ pkgs, ... }:
{
  boot = {
    #NOTE: https://github.com/chaotic-cx/nyx/blob/ab2a92d8148e549b5fcdff81aea5c3e40672f733/shared/make-microarch.nix#L30
    # does not seem to support x86-64-v4 or zen4 package
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

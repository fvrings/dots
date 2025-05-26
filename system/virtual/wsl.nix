{ lib, pkgs, ... }:
{
  wsl = {
    enable = true;
    defaultUser = "ring";
    interop.includePath = false;
    startMenuLaunchers = true;
  };

  networking = {
    nftables.enable = lib.mkForce false;
  };

  boot.initrd.systemd.enable = lib.mkForce false;
  boot.loader.systemd-boot.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [ wl-clipboard ];
}

{ lib, ... }:
{
  wsl.enable = true;
  wsl.defaultUser = "ring";

  networking = {
    nftables.enable = lib.mkForce false;
  };

  boot.initrd.systemd.enable = lib.mkForce false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
}

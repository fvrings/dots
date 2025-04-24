{
  imports = [ ./luks-lvm.nix ];
  disko.devices.disk.main.device = "/dev/nvme0n1";
}

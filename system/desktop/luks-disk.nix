_: {

  systemd.services.luks-secondary = {
    description = "Unlock LUKS secondary drive";
    wantedBy = [ "multi-user.target" ];
    before = [ "mnt-secondary.mount" ]; # optional: order before mounting
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/cryptsetup open \
          --key-file /etc/keys/second \
          /dev/disk/by-uuid/21e2516c-20ac-44a3-8d16-c6578baa1f33 \
          secondary
      '';
      RemainAfterExit = true;
    };
    unitConfig = {
      ConditionPathExists = "/dev/disk/by-uuid/21e2516c-20ac-44a3-8d16-c6578baa1f33";
    };
  };

  fileSystems."/home/ring/data" = {
    device = "/dev/mapper/secondary";
    fsType = "ext4"; # or btrfs, xfs, etc.
    options = [ "noauto" ];
    neededForBoot = false;
  };

  systemd.mounts = [
    {
      what = "/dev/mapper/secondary";
      where = "/home/ring/data";
      type = "ext4";
      options = "noauto";
      wantedBy = [ "multi-user.target" ];
      unitConfig.ConditionPathExists = "/dev/mapper/secondary";
    }
  ];
}

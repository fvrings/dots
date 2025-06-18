_: {

  systemd.services.luks-secondary = {
    description = "Unlock LUKS secondary drive";
    wantedBy = [ "multi-user.target" ];
    before = [ "mount-secondary.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/cryptsetup open \
          --key-file /etc/nixos/second \
          /dev/disk/by-uuid/21e2516c-20ac-44a3-8d16-c6578baa1f33 \
          secondary
      '';
      RemainAfterExit = true;
    };
    unitConfig = {
      ConditionPathExists = "/dev/disk/by-uuid/21e2516c-20ac-44a3-8d16-c6578baa1f33";
    };
  };

  systemd.services.mount-secondary = {
    description = "Mount secondary disk";
    after = [ "luks-secondary.service" ];
    wants = [ "luks-secondary.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/mount /home/ring/data";
    };
    unitConfig = {
      ConditionPathExists = "/dev/mapper/secondary";
    };
    wantedBy = [ "multi-user.target" ];
  };

  fileSystems."/home/ring/data" = {
    device = "/dev/mapper/secondary";
    fsType = "ext4";
    options = [ "noauto" ];
    neededForBoot = false;
  };
}

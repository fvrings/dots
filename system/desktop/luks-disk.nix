_: {

  systemd.services = {
    luks-secondary = {
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
    mount-secondary = {
      description = "Mount secondary disk";
      after = [ "luks-secondary.service" ];
      wants = [ "luks-secondary.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/mount /home/ring/data/sdd";
      };
      unitConfig = {
        ConditionPathExists = "/dev/mapper/secondary";
      };
      wantedBy = [ "multi-user.target" ];
    };
    luks-black = {
      description = "Unlock LUKS black drive";
      wantedBy = [ "multi-user.target" ];
      before = [ "mount-black.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          /run/current-system/sw/bin/cryptsetup open \
            --key-file /etc/nixos/black \
            /dev/disk/by-uuid/08b0a4be-60c2-4c4c-a3ba-f9b90185fcff \
            black
        '';
        RemainAfterExit = true;
      };
      unitConfig = {
        ConditionPathExists = "/dev/disk/by-uuid/08b0a4be-60c2-4c4c-a3ba-f9b90185fcff";
      };
    };

    mount-black = {
      description = "Mount black disk";
      after = [ "luks-black.service" ];
      wants = [ "luks-black.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/run/current-system/sw/bin/mount /home/ring/data/black";
      };
      unitConfig = {
        ConditionPathExists = "/dev/mapper/black";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };

  fileSystems."/home/ring/data/sdd" = {
    device = "/dev/mapper/secondary";
    fsType = "ext4";
    options = [ "noauto" ];
    neededForBoot = false;
  };

  fileSystems."/home/ring/data/black" = {
    device = "/dev/mapper/black";
    fsType = "xfs";
    options = [
      "noauto"
    ];
    neededForBoot = false;
  };
}

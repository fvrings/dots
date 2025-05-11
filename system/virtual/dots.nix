_: {
  fileSystems."/etc/nixos/dots" = {
    device = "dots";
    fsType = "virtiofs";
    options = [
      "defaults" # Allows any user to mount and unmount
    ];
  };
}

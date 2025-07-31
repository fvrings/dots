_: {
  boot = {
    initrd.systemd.enable = true;
    supportedFilesystems = [
      "ntfs"
      "bcachefs"
      # "zfs"
      "xfs"
    ];
    tmp.useTmpfs = true;
    # plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "2";
        configurationLimit = 5;
      };
    };
    # zfs.forceImportRoot = false;
  };
  networking.hostId = "bdc578d5";
}

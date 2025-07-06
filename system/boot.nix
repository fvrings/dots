_: {
  boot = {
    initrd.systemd.enable = true;
    supportedFilesystems = [
      "ntfs"
      "bcachefs"
    ];
    tmp.useTmpfs = true;
    plymouth.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "2";
        configurationLimit = 5;
      };
    };
  };
}

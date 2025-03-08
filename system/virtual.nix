_: {
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;
    };
    incus.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://docker.mirrors.ustc.edu.cn/" ];
      };
    };
  };
}

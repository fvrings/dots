{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            pkgs.OVMFFull.fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
    incus.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://docker.mirrors.ustc.edu.cn/" ];
      };
    };
  };
}

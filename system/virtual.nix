{ pkgs, ... }:
{
  virtualisation = {
    vmware.host.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = with pkgs; [ virtiofsd ];
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

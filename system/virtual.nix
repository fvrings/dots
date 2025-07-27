{ pkgs, ... }:
{
  virtualisation = {
    # vmware.host.enable = true;
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
    incus = {
      enable = true;
      preseed.networks = [
        {
          config = {
            "ipv4.address" = "10.0.100.1/24";
            "ipv4.nat" = "true";
          };
          name = "incusbr0";
          type = "bridge";
        }
      ];
    };
    docker = {
      enable = true;
      daemon.settings = {
        registry-mirrors = [ "https://docker.mirrors.ustc.edu.cn/" ];
      };
    };
  };
}

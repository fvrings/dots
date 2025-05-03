{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "start";
      qemu = {
        # package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          # packages = [
          #   (pkgs.OVMF.override {
          #     secureBoot = true;
          #     tpmSupport = true;
          #   }).fd
          # ];
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

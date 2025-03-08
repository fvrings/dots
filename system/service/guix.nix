{
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/misc/guix/default.nix
  services.guix = {
    enable = true;
    # The store directory where the Guix service will serve to/from.
    storeDir = "/gnu/store";
    extraArgs = [
      "--substitute-urls=https://mirror.sjtu.edu.cn/guix/"
    ];
    gc = {
      enable = true;
      # https://guix.gnu.org/en/manual/en/html_node/Invoking-guix-gc.html
      extraArgs = [
        "--delete-generations=1m"
        "--free-space=10G"
        "--optimize"
      ];
    };
  };
}

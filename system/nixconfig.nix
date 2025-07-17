{
  lib,
  config,
  inputs,
  # pkgs,
  ...
}:
{
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowBroken = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "openssl-1.1.1w"
  #   # "electron-11.5.0"
  # ];
  nix = {
    # package = inputs.lix-module.packages.nix;
    extraOptions = ''
      !include ${config.sops.secrets."gh".path}
    '';
    gc = {
      # automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
    nixPath = lib.mkForce [ "/etc/nix/inputs" ];
    settings = {
      # Optimise storage
      # you can alse optimise the store manually via:
      #    nix-store --optimise
      # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
      auto-optimise-store = true;
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
        # BUG: does not work
        # "coerce-integers"
        # "pipe-operators"
      ];
      # Opinionated: disable global registry
      # flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      substituters = [
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        # "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "pwndbg.cachix.org-1:HhtIpP7j73SnuzLgobqqa8LVTng5Qi36sQtNt79cD3k="
        # "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
        # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
      trusted-users = [ "@wheel" ];
    };
    channel.enable = false; # remove nix-channel related tools & configs, we use flakes instead.
    registry.nixpkgs.flake = inputs.nixpkgs;
    registry.nixstb.flake = inputs.nixpkgs-stable;
  };
}

{
  description = "dark art";

  outputs =
    {
      # self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./treefmt.nix ];
      systems = [ "x86_64-linux" ];
      flake = rec {
        nixosConfigurations = {
          vm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./system/virtual
              ./home
              ./module
              ./overlay
            ];
            specialArgs = { inherit inputs; };
          };
          art = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./system/desktop
              ./home
              ./module
              ./overlay
            ];
            specialArgs = { inherit inputs; };
          };
        };
        homeConfigurations = {
          ring = nixosConfigurations.art.config.home-manager.users.ring.home;
          hypr = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            extraSpecialArgs = { inherit inputs; };
            modules = [
              ./home/desktop/hypridle.nix
              ./home/desktop/hyprland.nix
              ./home/desktop/hyprlock.nix
              {
                home = {
                  username = "ring";
                  homeDirectory = "/home/ring";
                  stateVersion = "24.11";
                };
                nixpkgs.config.allowUnfree = true;
                xdg = {
                  enable = true;
                  configFile = {
                    "hypr/scripts" = {
                      source = ./home/desktop/scripts;
                    };
                  };
                };
              }
            ];
          };
        };
      };
      perSystem =
        { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell {
            name = "rings";
            packages = with pkgs; [
              git
              vim
              sops
            ];
          };
        };
    };
  inputs = {
    #TODO: add disko until https://github.com/nix-community/disko/issues/511
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #NOTE:https://flake.parts/best-practices-for-module-writing
    flake-parts.url = "github:hercules-ci/flake-parts";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow";
      inputs.hyprland.follows = "hyprland";
    };
    hypr-dynamic-cursors = {
      url = "github:VirtCode/hypr-dynamic-cursors";
      inputs.hyprland.follows = "hyprland"; # to make sure that the plugin is built for the correct version of hyprland
    };
    # pyprland.url = "github:hyprland-community/pyprland";
    # flake-root.url = "github:srid/flake-root";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    astal.url = "github:Aylur/astal";
    catppuccin.url = "github:catppuccin/nix";
    yazi.url = "github:sxyazi/yazi";
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-starship = {
      url = "github:Rolv-Apneseth/starship.yazi";
      flake = false;
    };
    yatline = {
      url = "github:imsi32/yatline.yazi";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zjstatus = {
      url = "github:dj95/zjstatus";
    };
    # lix-module = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-1.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    niri.url = "github:sodiboo/niri-flake";
    ucodenix.url = "github:e-tho/ucodenix";
    pwndbg.url = "github:pwndbg/pwndbg";
  };
  nixConfig = {
    extra-substituters = [
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.garnix.io"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://hyprland.cachix.org"
      "https://yazi.cachix.org"
      "https://ags.cachix.org"
      "https://pwndbg.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pwndbg.cachix.org-1:HhtIpP7j73SnuzLgobqqa8LVTng5Qi36sQtNt79cD3k="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };

}

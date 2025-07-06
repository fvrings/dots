{
  description = "art";

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./treefmt.nix
        ./module
      ];
      systems = [ "x86_64-linux" ];
      flake = {
        nixosConfigurations = {
          wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./host/wsl
            ];
            specialArgs = { inherit inputs; };
          };
          vm = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./host/vm
            ];
            specialArgs = { inherit inputs; };
          };
          art = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./host/art
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };
      perSystem =
        { pkgs, ... }:
        let
          configuredProgramsSystem = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./home/yazi
              ./home/tmux
              {
                system.stateVersion = "25.11";
              }
            ];
            specialArgs = { inherit inputs; };
          };

          # Extract the configured tmux package
          # programs.tmux sets config.programs.tmux.package to the configured binary.
          tmuxWithConfig = configuredProgramsSystem.config.programs.tmux.package;

          # Extract the configured yazi package
          # programs.yazi places the configured binary in environment.systemPackages.
          yaziWithConfig = builtins.head (
            builtins.filter (
              p: builtins.hasAttr "pname" p && p.pname == "yazi"
            ) configuredProgramsSystem.config.environment.systemPackages
          );

        in
        {
          packages = {
            mpv = import ./home/mpv/pkg.nix { inherit pkgs; };
            yazi = yaziWithConfig;
            tmux = tmuxWithConfig;
          };
          devShells.default = pkgs.mkShell {
            name = "ring";
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
    impermanence.url = "github:nix-community/impermanence";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-release.url = "github:NixOS/nixpkgs/release-25.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #NOTE:https://flake.parts/best-practices-for-module-writing
    flake-parts.url = "github:hercules-ci/flake-parts";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
    treefmt-nix.url = "github:fvrings/treefmt-nix/feat/qmlformat";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    daeuniverse.url = "github:daeuniverse/flake.nix";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake-root.url = "github:srid/flake-root";
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
    yazi-fast-enter = {
      url = "github:ourongxing/fast-enter.yazi";
      flake = false;
    };
    bunny = {
      url = "github:stelcodes/bunny.yazi";
      flake = false;
    };
    rich-preview = {
      url = "github:AnirudhG07/rich-preview.yazi";
      flake = false;
    };
    ouch = {
      url = "github:ndtoan96/ouch.yazi";
      flake = false;
    };
    yazi-kanagawa = {
      url = "github:marcosvnmelo/kanagawa-dragon.yazi";
      flake = false;
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # zjstatus = {
    #   url = "github:dj95/zjstatus";
    # };
    ucodenix = {
      url = "github:e-tho/ucodenix";
    };
    pwndbg.url = "github:pwndbg/pwndbg";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ignis = {
    #   url = "github:ignis-sh/ignis";
    #   # ! Important to override
    #   # Nix will not allow overriding dependencies if the input
    #   # doesn't follow your system pkgs
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # niri.url = "github:sodiboo/niri-flake";
    # NOTE: HM :(
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };
  nixConfig = {
    extra-substituters = [
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://yazi.cachix.org"
      # "https://ags.cachix.org"
      "https://pwndbg.cachix.org"
      "https://chaotic-nyx.cachix.org"
      # "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pwndbg.cachix.org-1:HhtIpP7j73SnuzLgobqqa8LVTng5Qi36sQtNt79cD3k="
      # "ags.cachix.org-1:naAvMrz0CuYqeyGNyLgE010iUiuf/qx6kYrUv3NwAJ8="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      # "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

}

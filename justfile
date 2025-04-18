alias o:=update-os
alias v:=update-vm
alias f:=update-flake
alias n:=update-neovim
alias m:=edit-mini
alias c:=clear
alias b:=clear-boot
alias h:=home

update-os *args:
  nh os switch -H art . {{args}}
update-vm *args:
  nh os switch -H vm . {{args}}
update-flake:
  nix flake update
update-neovim:
  nix flake update neovim-nightly-overlay
edit-mini:
  nix run nixpkgs#sops secrets/mimi.yaml
clear:
  sudo nix-collect-garbage -d
clear-boot:
  sudo /run/current-system/bin/switch-to-configuration boot
check:
  nix flake check
home:
  nix run nixpkgs#home-manager -- switch --flake .#ring
hypr:
  nix run nixpkgs#home-manager -- switch --flake .#hypr
setup-disk:
  sudo nix --experimental-features "nix-command flakes" --option substituters https://mirrors.ustc.edu.cn/nix-channels/store run github:nix-community/disko/latest -- --mode destroy,format,mount ./system/disko/main.nix
nixos-install-vm:
  sudo nixos-install --option substituters https://mirrors.ustc.edu.cn/nix-channels/store --flake .#vm
nixos-install-art:
  sudo nixos-install --option substituters https://mirrors.ustc.edu.cn/nix-channels/store --flake .#art
install-vm:
  sudo nix --extra-experimental-features "nix-command flakes" run --option substituters https://mirrors.ustc.edu.cn/nix-channels/store 'github:nix-community/disko/latest#disko-install' --  --flake '.#vm' --disk main /dev/vda
enable-tpm:
  sudo systemd-cryptenroll --tpm2-device=auto /dev/nvme0n1p2

{ pkgs, ... }:
{
  home = {
    username = "ring";
    homeDirectory = "/home/ring";

    stateVersion = "24.11";
  };
  xdg = {
    enable = true;
    configFile = {
      "hypr/scripts" = {
        source = ./desktop/scripts;
      };
      "wezterm" = {
        source = ../config/wezterm;
      };
    };
  };
  home.file.".cargo/config.toml".text = ''
    [source.crates-io]
    replace-with = 'rsproxy-sparse'
    [source.rsproxy]
    registry = "https://rsproxy.cn/crates.io-index"
    [source.rsproxy-sparse]
    registry = "sparse+https://rsproxy.cn/index/"
    [registries.rsproxy]
    index = "https://rsproxy.cn/crates.io-index"
    [net]
    git-fetch-with-cli = true
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"]
  '';
  catppuccin = {
    flavor = "mocha";
    enable = true;
    accent = "rosewater";
  };
  programs = {
    # emacs = {
    #   enable = true;
    #   package = pkgs.emacs29-pgtk;
    #   extraPackages = epkgs: [
    #     epkgs.pdf-tools
    #     epkgs.org-download
    #   ];
    # };
    uv = {
      enable = true;
      settings = {
        pip.index-url = "http://mirrors.aliyun.com/pypi/simple/";
      };
    };
    ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      # configDir = ../ags;

      # package = inputs.ags.packages.${pkgs.system}.agsFull;
      # extraPackages = [
      #   inputs.ags.packages.${pkgs.system}.battery
      #   inputs.ags.packages.${pkgs.system}.network
      #   inputs.ags.packages.${pkgs.system}.hyprland
      # ];
    };
    kitty = {
      enable = true;
      font.size = 13;
      font.name = "monospace";
      settings = {
        "clipboard_control" = "write-clipboard write-primary read-clipboard read-primary no-append";
        "hide_window_decorations" = true;
      };
    };
    foot = {
      enable = true;
      settings = {
        main = {
          font = "monospace:size=13";
        };
      };
    };
    zathura = {
      enable = true;
      options = {
        window-title-basename = "true";
        selection-clipboard = "clipboard";
        adjust-open = "width";
      };
    };
    alacritty = {
      enable = true;
      settings = {
        font = {
          size = 13;
        };
        window = {
          decorations = "none";
        };
      };
    };
    wezterm = {
      enable = false;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
          kimpanel.extensionUuid
          system-monitor.extensionUuid
          window-list.extensionUuid
          workspace-indicator.extensionUuid
          expandable-notifications.extensionUuid
          ideapad.extensionUuid
        ];
      };
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}

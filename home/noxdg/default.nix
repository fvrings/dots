{ pkgs, lib, ... }:
let
  # Define common applications as variables for clarity
  firefoxApp = "firefox.desktop";
  zathuraApp = "org.pwmt.zathura.desktop";
  neovideApp = "neovide.desktop";
  mpvApp = "mpv.desktop";
  imvApp = "imv.desktop";
  yaziApp = "yazi.desktop";
  googleChromeApp = "google-chrome.desktop";

  # Define the applications and their associated MIME types as a list of records
  applicationMimeMappings = [
    {
      app = firefoxApp;
      mimeTypes = [
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xht"
        "application/x-extension-xhtml"
        "text/html"
        "x-scheme-handler/about"
        "x-scheme-handler/ftp"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/unknown"
      ];
    }
    {
      app = zathuraApp;
      mimeTypes = [
        "application/epub+zip"
        "application/pdf"
      ];
    }
    {
      app = neovideApp;
      mimeTypes = [
        "application/json"
        "text/plain"
      ];
    }
    {
      app = mpvApp;
      mimeTypes = [
        "image/gif" # mpv can play GIFs
        "video/avi"
        "video/mkv"
        "video/mp4"
      ];
    }
    {
      app = imvApp;
      mimeTypes = [
        "image/jpeg"
        "image/png"
        "image/svg"
      ];
    }
    {
      app = yaziApp;
      mimeTypes = [ "inode/directory" ];
    }
    {
      app = googleChromeApp;
      mimeTypes = [ "x-scheme-handler/chrome" ];
    }
  ];

  # Transform the list of mappings into the final defaultApplications attribute set
  # We iterate over each 'mapping' in applicationMimeMappings
  # For each mapping, we generate an attribute set (MIME type -> app)
  # Finally, we merge all these generated attribute sets together.
  defaultMimeAssociations = lib.mergeAttrsList (
    lib.map (mapping: lib.genAttrs mapping.mimeTypes (_mimeType: mapping.app)) applicationMimeMappings
  );
in
{
  home = {
    file = {
      ".npmrc".text = "registry=https://registry.npmmirror.com";
      ".config/nix-extra/sqlite3.path".text = "${pkgs.sqlite.out}/lib/libsqlite3.so";
      ".cargo/config.toml".text = (builtins.readFile ./cargo.toml) + ''
        [target.x86_64-unknown-linux-gnu]
        linker = "clang"
          rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold-wrapped}/bin/mold"]
      '';
    };
  };

  xdg.mimeApps.defaultApplications = defaultMimeAssociations;
}

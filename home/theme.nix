let

  genWallpaper =
    {
      url,
      sha256,
      ext ? "jpg",
    }:
    builtins.fetchurl {
      name = "wallpaper-${sha256}.${ext}";
      inherit url sha256;
    };
in
{
  theme = {
    wallpaper = genWallpaper {
      url = "https://unsplash.com/photos/OcocJTvaz3k/download?ixid=M3wxMjA3fDB8MXxhbGx8MXx8fHx8fHx8MTc0NDk3MTAxNHw&force=true";
      sha256 = "06gjhq5gl4f7f8yyarbnmg9klsm4n92ba0fvx2djphfydbinkyl0";
    };
    wallpaper-light = genWallpaper {
      url = "https://unsplash.com/photos/NPGj5EVCy3o/download?ixid=M3wxMjA3fDB8MXx0b3BpY3x8Ym84alFLVGFFMFl8fHx8fDJ8fDE3NTIyODUwMjB8&force=true";
      sha256 = "216cb5565f98b206a55681c3c75164e2b7f760b928d1fbb105ba12166754b547";
    };
    wallpaper-anime = genWallpaper {
      url = "https://unsplash.com/photos/nymNqy2C4Q4/download?ixid=M3wxMjA3fDB8MXxhbGx8MXx8fHx8fHx8MTc1MjcyMjc0OXw&force=true";
      sha256 = "e21b9807911ac95153ecb7291804571a520f18566a90e469a91950e16871abd7";
    };
    shell = "qs";
    dwl = false;
  };
}

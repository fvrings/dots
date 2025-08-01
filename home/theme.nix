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
      url = "https://youke1.picui.cn/s1/2025/07/20/687ce95e31ea6.jpg";
      # url = "https://unsplash.com/photos/nymNqy2C4Q4/download?ixid=M3wxMjA3fDB8MXxhbGx8MXx8fHx8fHx8MTc1MjcyMjc0OXw&force=true";
      sha256 = "5bdfe90ac444ef663c4a2b1c75d161c13ec3af98d00cd4314d8052e469c88812";
    };
    wallpaper-universe = genWallpaper {
      url = "https://science.nasa.gov/wp-content/uploads/2023/09/ssc2006-02a-0.jpg";
      sha256 = "bd483538b3e293561ea1f8e08b5955a5e348a178356a84b5ca75b7438f739485";
    };
    shell = "qs";
  };
}

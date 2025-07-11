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
      url = "https://unsplash.com/photos/4dpAqfTbvKA/download?ixid=M3wxMjA3fDB8MXxzZWFyY2h8M3x8dW5pdmVyc2V8ZW58MHx8fHwxNzUyMjQyNjUyfDA&force=true";
      sha256 = "6fb5c06c935831e19df259dd86154c42497fc2634e4bf3ccee8438a91dd245b7";
    };
    shell = "qs";
  };
}

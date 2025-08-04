{
  stdenvNoCC,
  fetchFromGitHub,
  hicolor-icon-theme,
  jdupes,
}:

stdenvNoCC.mkDerivation rec {
  pname = "cryptocurrency-icons";
  version = "master";

  src = fetchFromGitHub {
    owner = "ErikThiart";
    repo = pname;
    rev = version;
    hash = "sha256-62O/rAdd30wUJM6viAvBAIPn/CofUFLVzDLAXWm+0LU=";
  };

  nativeBuildInputs = [ jdupes ];
  propagatedBuildInputs = [ hicolor-icon-theme ];

  dontPatchELF = true;
  dontRewriteSymlinks = true;

  installPhase = ''
    runHook preInstall

    for size in 16 32 64 128; do
      src_dir="$size"
      dest_dir="$out/share/icons/hicolor/''${size}x''${size}/apps"
      mkdir -p "$dest_dir"
      install -m644 $src_dir/*.png "$dest_dir/"
    done

    jdupes --link-soft --recurse $out/share/icons/hicolor

    runHook postInstall
  '';
}

{
  pkgs,
  ...
}:
let
  rime-rings-custom = pkgs.callPackage ./rime-rings-custom.nix { };

  fcitx5-rime-with-addons =
    (pkgs.fcitx5-rime.override {
      librime = pkgs.nur.repos.xddxdd.lantianCustomized.librime-with-plugins;
      rimeDataPkgs = with pkgs; [
        nur.repos.xddxdd.rime-dict
        nur.repos.xddxdd.rime-ice
        nur.repos.xddxdd.rime-moegirl
        nur.repos.xddxdd.rime-zhwiki
        rime-data
        rime-rings-custom
      ];
    }).overrideAttrs
      (old: {
        # Prebuild schema data
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.parallel ];
        postInstall = (old.postInstall or "") + ''
          for F in $out/share/rime-data/*.schema.yaml; do
            echo "rime_deployer --compile "$F" $out/share/rime-data $out/share/rime-data $out/share/rime-data/build" >> parallel.lst
          done
          parallel -j$(nproc) < parallel.lst || true
        '';
      });
in
{
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          kdePackages.fcitx5-qt
          fcitx5-rime-with-addons
          # fcitx5-rose-pine
        ];
      };
    };
  };
}

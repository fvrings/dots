# from xddxdd
{
  lib,
  linkFarm,
  writeText,
  ...
}:
let
  makeDict =
    name: dicts:
    let
      body = builtins.toJSON {
        inherit name;
        version = "1.0";
        sort = "by_weight";
        use_preset_vocabulary = false;
        import_tables = dicts;
      };
    in
    ''
      # Rime dictionary
      # encoding: utf-8

      ---
      ${body}

      ...
    '';
in
linkFarm "rime-rings-custom" (
  lib.mapAttrs writeText {
    "share/rime-data/default.custom.yaml" = builtins.toJSON {
      patch = {
        # 雾凇拼音
        __include = "rime_ice_suggestion:/";

        schema_list = [ { schema = "double_pinyin_flypy"; } ];
        # "menu/page_size" = 9;
      };
    };

    # 雾凇拼音
    "share/rime-data/double_pinyin_flypy.custom.yaml" = builtins.toJSON {
      patch = {
        # NOTE:no idea why not work
        # "style/font_point" = 15;
        "translator/dictionary" = "rings_rime_ice";
      };
    };

    "share/rime-data/rings_rime_ice.dict.yaml" = makeDict "rings_rime_ice" [
      "cn_dicts/8105"
      "cn_dicts/41448"
      "cn_dicts/base"
      "cn_dicts/ext"
      "cn_dicts/tencent"
      "cn_dicts/others"

      "pinyin_simp"
      "luna_pinyin.anime"
      "luna_pinyin.basis"
      "luna_pinyin.biaoqing"
      "luna_pinyin.chat"
      "luna_pinyin.classical"
      "luna_pinyin.cn_en"
      "luna_pinyin.computer"
      "luna_pinyin.daily"
      "luna_pinyin.diet"
      "luna_pinyin.game"
      "luna_pinyin.gd"
      "luna_pinyin.hanyu"
      "luna_pinyin.history"
      "luna_pinyin.idiom"
      "luna_pinyin.moba"
      "luna_pinyin.movie"
      "luna_pinyin.music"
      "luna_pinyin.name"
      "luna_pinyin.net"
      "luna_pinyin.poetry"
      "luna_pinyin.practical"
      "luna_pinyin.sougou"
      "luna_pinyin.website"

      "moegirl"
      "zhwiki"
    ];
  }
)

{
  pkgs,
  ...
}:
with pkgs;
let
  #TODO: use hjem here
  #https://github.com/xddxdd/nixos-config/blob/362feb5732efe1682b505d941b75c97279d2208c/home/client-apps/mpv.nix
  anime4K_Input = ''
    # Optimized shaders for lower-end GPU:
    CTRL+1 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A (Fast)"
    CTRL+2 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B (Fast)"
    CTRL+3 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C (Fast)"
    CTRL+4 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_S.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode A+A (Fast)"
    CTRL+5 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_M.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_Soft_S.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode B+B (Fast)"
    CTRL+6 no-osd change-list glsl-shaders set "${pkgs.anime4k}/Anime4K_Clamp_Highlights.glsl:${pkgs.anime4k}/Anime4K_Upscale_Denoise_CNN_x2_M.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x2.glsl:${pkgs.anime4k}/Anime4K_AutoDownscalePre_x4.glsl:${pkgs.anime4k}/Anime4K_Restore_CNN_S.glsl:${pkgs.anime4k}/Anime4K_Upscale_CNN_x2_S.glsl"; show-text "Anime4K: Mode C+A (Fast)"

    CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
  '';

in
{
  programs = {
    mpv = {
      enable = true;
      config = {
        hwdec = "auto-safe";
        vo = "gpu-next";
        profile = "high-quality";
        gpu-api = "vulkan";
        osd-bar = false;
        target-colorspace-hint = true;
        save-position-on-quit = true;
        keep-open = true;
        alang = "chi,zho,zh,zh-CN,zh-TW,zh-HK,zh-MO";
        slang = "chi,zho,zh,zh-CN,zh-TW,zh-HK,zh-MO";
        screenshot-format = "png";
        screenshot-dir = "~/Pictures/mpv/";
      };
      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
      ];
      extraInput =
        anime4K_Input
        + ''
          space           cycle pause; script-binding uosc/flash-pause-indicator
          m               no-osd cycle mute; script-binding uosc/flash-volume
          [               no-osd add speed -0.25; script-binding uosc/flash-speed
          ]               no-osd add speed  0.25; script-binding uosc/flash-speed
          BS              no-osd set speed 1; script-binding uosc/flash-speed
          >               script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline
          <               script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline
          MBTN_RIGHT_DBL  script-binding uosc/menu
        '';
      scriptOpts = {
        uosc = {
          languages = "slang,zh-hans";
          pause_indicator = "manual";
        };
      };
    };
  };

}

_: {
  hjem.users.ring.files = {
    ".config/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Kanagawa-B
      gtk-icon-theme-name=BeautyLine
      gtk-font-name=LXGW WenKai Bold 14
      gtk-cursor-theme-name=LyraF-cursors
      gtk-cursor-theme-size=22
      gtk-toolbar-style=GTK_TOOLBAR_ICONS
      gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
      gtk-button-images=0
      gtk-menu-images=0
      gtk-enable-event-sounds=1
      gtk-enable-input-feedback-sounds=0
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle=hintslight
      gtk-xft-rgba=rgb
      gtk-application-prefer-dark-theme=1
    '';
    ".config/gtk-3.0/gtk.css".text = ''
      @import 'colors.css';
    '';
    ".config/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Kanagawa-B
      gtk-icon-theme-name=BeautyLine
      gtk-font-name=LXGW WenKai Bold 14
      gtk-cursor-theme-name=LyraF-cursors
      gtk-cursor-theme-size=22
      gtk-application-prefer-dark-theme=1
    '';
    ".config/gtk-4.0/gtk.css".text = ''
      @import 'colors.css';
    '';
  };
}

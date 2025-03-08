import { LIGHT, MUSIC } from "./Var";
function Lock() {
  return Widget.Box({
    vexpand: true,
    hexpand: true,
    vpack: "fill",
    css: "color:#F35382;",
    setup: (box) =>
      box.hook(MUSIC, () => {
        box.toggleClassName("popup", MUSIC.value);
      }),

    // vpack: "center",
    child: Widget.Label({
      hexpand: true,
      label: "󰟾",
    }),
  });
}
function Music() {
  return Widget.Box({
    vpack: "fill",
    hexpand: true,
    css: "color:#9AFA59;",
    setup: (box) =>
      box.hook(MUSIC, () => {
        box.toggleClassName("popup", MUSIC.value);
      }),

    // vpack: "center",
    child: Widget.Label({
      hexpand: true,
      label: "󰽰",
    }),
  });
}
function PanelChild() {
  return Widget.Box(
    {
      class_name: "player",
      css: "min-height:200px; min-width:480px;font-size:80px;background-color:@theme_bg_color;border-radius:68px;",
    },
    Widget.Box(
      {
        vexpand: true,
      },
      Music(),
      Lock(),
    ),
  );
}

export const Panel = Widget.Window({
  name: "panel",
  visible: false,
  css: "background-color:transparent;",
  keymode: "exclusive",
  setup: (self) => {
    self.keybind("q", () => {
      App.closeWindow("panel");
    });
    self.keybind("m", () => {
      MUSIC.setValue(!MUSIC.value);
      App.closeWindow("panel");
      App.toggleWindow("player");
    });
    self.keybind("l", () => {
      LIGHT.setValue(!LIGHT.value);
      App.closeWindow("panel");
      App.toggleWindow("light");
    });
  },
  // child: Media(),
  child: PanelChild(),
});

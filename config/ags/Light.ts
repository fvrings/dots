import bright from "./service/bright";

function Lighter() {
  return Widget.Box({
    vertical: true,
    css: "min-height: 200px; min-width: 288px;", // small hack to make it visible
    visible: true,
    children: [
      Widget.Label({
        label: "",
        css: "color:#FF7826;font-size:80px;",
        hpack: "center",
        vexpand: true,
      }),
    ],
  });
}
export const Light = Widget.Window({
  name: "light",
  visible: false,
  child: Lighter(),
  keymode: "exclusive",
  setup: (self) => {
    self.keybind("q", () => {
      App.closeWindow("light");
    });
    self.keybind("j", () => {
      bright.screen_value -= 10;
    });
    self.keybind("k", () => {
      bright.screen_value += 10;
    });
  },
});

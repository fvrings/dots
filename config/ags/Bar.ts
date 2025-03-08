const hyprland = await Service.import("hyprland");
const audio = await Service.import("audio");
const battery = await Service.import("battery");
const systemtray = await Service.import("systemtray");
const network = await Service.import("network");
import { BTC, CPU, DATE, DOWN, LOGO, MEM, UP } from "./Var";
import bright from "./service/bright";

function range(length: number, start = 1) {
  return Array.from({ length }, (_, i) => i + start);
}
const Workspaces = (ws: number) =>
  Widget.Box({
    className: "workspaces",
    children: range(ws || 20).map((i) =>
      Widget.Label({
        attribute: i,
        vpack: "center",
        label: `${i}`,
        setup: (self) =>
          self.hook(hyprland, () => {
            self.toggleClassName("active", hyprland.active.workspace.id === i);
            self.toggleClassName(
              "occupied",
              (hyprland.getWorkspace(i)?.windows || 0) > 0,
            );
          }),
      }),
    ),
    setup: (box) => {
      if (ws === 0) {
        box.hook(hyprland.active.workspace, () =>
          box.children.map((btn) => {
            btn.visible = hyprland.workspaces.some(
              (ws) => ws.id === btn.attribute,
            );
          }),
        );
      }
    },
  });

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: DATE.bind().as((d) => `󰥔  ${d}`),
    css: "color:pink;",
  });
}

function Brightness() {
  return Widget.Button({
    on_primary_click: () => (bright.screen_value += 10),
    on_secondary_click: () => (bright.screen_value -= 10),
    child: Widget.Label({
      label: bright.bind("screen_value").as((v) => `󰃠  ${v}%`),
      css: "color:#FA8B64;",
    }),
  });
}
function Volume() {
  return Widget.Button({
    on_scroll_up: () => (audio.speaker.volume += 0.02),
    on_scroll_down: () => (audio.speaker.volume -= 0.02),
    on_clicked: () =>
      (audio.speaker.volume = audio.speaker.volume > 0 ? 0 : 0.4),
    child: Widget.Label({
      label: audio.speaker.bind("volume").as((v) => {
        const percent = Math.floor(v * 100);
        let icon: string;
        if (percent > 100) {
          icon = "󰕾 ";
        } else if (percent > 50) {
          icon = "󰖀 ";
        } else if (percent > 0) {
          icon = "󰕿 ";
        } else {
          icon = "󰸈 ";
        }
        return `${icon} ${percent}%`;
      }),
      css: "color:#FF5AAA;",
    }),
  });
}
function Wallpaper() {
  return Widget.Button({
    on_primary_click: () =>
      Utils.execAsync(["bash", "-c", "~/.config/hypr/scripts/change_bg.sh"]),
    child: Widget.Label({
      label: "󰸉 ",
      css: "color:#C896FF;",
    }),
  });
}
function Battery() {
  return Widget.Button({
    child: Widget.Label({
      class_name: "battery",
      label: battery.bind("percent").as((p) => {
        let icon: string;
        if (p === 100) {
          icon = "󰁹";
        } else if (p > 90) {
          icon = "󰂂";
        } else if (p > 80) {
          icon = "󰂁";
        } else if (p > 70) {
          icon = "󰂀";
        } else if (p > 60) {
          icon = "󰁿";
        } else if (p > 50) {
          icon = "󰁾";
        } else if (p > 40) {
          icon = "󰁽";
        } else if (p > 30) {
          icon = "󰁼";
        } else if (p > 20) {
          icon = "󰁺";
        } else if (p >= 0) {
          icon = "󰂃";
        } else {
          icon = "󰚥";
        }
        return icon == "󰚥" ? icon : `${icon} ${p}%`;
      }),
      setup: (self) => {
        self.hook(battery, () => {
          self.toggleClassName("charging", battery.charging === true);
        });
      },
    }),
  });
}
function Cpu() {
  return Widget.Button({
    child: Widget.Label({
      label: CPU.bind().as((c) => {
        return `  ${Math.floor(Number(c))}%`;
      }),
      css: "color:#28AF96;",
    }),
  });
}
function Mem() {
  return Widget.Button({
    child: Widget.Label({
      label: MEM.bind().as((c) => {
        return `  ${Math.floor(Number(c))}%`;
      }),
      css: "color:#FFB446;",
    }),
  });
}
function Heart() {
  return Widget.Button({
    on_clicked: () => {
      Utils.exec("reboot");
    },
    child: Widget.Label({
      label: " ",
      css: "color:#FF190F;",
    }),
  });
}
function Btc() {
  return Widget.Button({
    child: Widget.Label({
      label: BTC.bind().as((b) => {
        return ` ${Math.floor(Number(b))}`;
      }),
      css: "color:#FFDC46;",
    }),
  });
}
function Network() {
  return Widget.Button({
    child: Widget.Label({
      //BUG: this does not keep update
      label: network.wifi.bind("ssid").as((w) => {
        return `󰖩 ${w}`;
        // return `󰖩 ${w} 󰒢 ${strength}%`;
      }),
      css: "color:#EB3C87;border:none;",
    }),
  });
}
function gen_speed(raw: string, icon: string) {
  if (raw.endsWith("K")) {
    if (raw.length > 4) {
      return `${icon} ${(
        Number(raw.substring(0, raw.length - 1)) / 1024 / 2
      ).toFixed(2)}M/s`;
    } else {
      return `${icon} ${Math.floor(Number(raw) / 2)}/s`;
    }
  } else if (raw.endsWith("M")) {
    return `${icon} ${(Number(raw) / 2).toFixed(2)}/s`;
  } else {
    if (raw.length > 3) {
      return `${icon} ${Math.floor(Number(raw) / 1024 / 2)}K/s`;
    } else {
      return `${icon} ${Math.floor(Number(raw) / 2)}B/s`;
    }
  }
}
function SpeedUp() {
  return Widget.Button({
    child: Widget.Label({
      label: UP.bind().as((w) => {
        let d = w.toString();
        return gen_speed(d, "󰕒 ");
      }),
      css: "color:#C3B9FF;",
    }),
  });
}
function SpeedDown() {
  return Widget.Button({
    child: Widget.Label({
      label: DOWN.bind().as((w) => {
        let d = w.toString();
        return gen_speed(d, "󰇚 ");
      }),
      css: "color:#C3B9FF;",
    }),
  });
}
function SysTray() {
  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    children: items,
  });
}

const icon = Widget.Icon({
  icon: LOGO.bind(),
  css: "font-size:22px;margin-left:8px",
});
// layout of the bar
function Left() {
  return Widget.Box({
    spacing: 8,
    children: [
      icon,
      Workspaces(7),
      Clock(),
      Btc(),
      // Network(),
    ],
  });
}

function Center() {
  return Widget.Box({
    spacing: 8,
    children: [SpeedUp(), SpeedDown(), Cpu(), Mem()],
  });
}

function Right() {
  return Widget.Box({
    hpack: "end",
    spacing: 8,
    children: [
      Wallpaper(),
      Volume(),
      Brightness(),
      Battery(),
      SysTray(),
      Heart(),
    ],
  });
}

export const Bar = Widget.Window({
  name: `bar`, // name has to be unique
  class_name: "bar",
  margins: [2, 9],
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",

  child: Widget.CenterBox({
    css: "font-size:20px;",
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
});

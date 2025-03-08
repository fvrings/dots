const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const players = mpris.bind("players");

const FALLBACK_ICON = "audio-x-generic-symbolic";
const PLAY_ICON = "cil--media-play";
const PAUSE_ICON = "cil--media-pause";
const PREV_ICON = "cil--media-skip-backward";
const NEXT_ICON = "cil--media-skip-forward";

function lengthStr(length) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}

function Play(player) {
  const img = Widget.Box({
    class_name: "img",
    vpack: "start",
    css: player.bind("cover_path").transform(
      (p) => `
            background-image: url('${p}');
            min-width: 400px;
    min-height: 400px;
    background-size: cover;
    background-position: center;
    border-radius: 13px;
    margin-right: 1em;
        `,
    ),
  });

  const title = Widget.Label({
    class_name: "title",
    wrap: true,
    hpack: "start",
    max_width_chars: 36,
    truncate: "end",
    css: "font-size:40px;",
    label: player.bind("track_title"),
  });

  const artist = Widget.Label({
    class_name: "artist",
    wrap: true,
    css: "font-size:20px;margin-right:10px;margin-top:50px;",
    hpack: "end",
    label: player.bind("track_artists").transform((a) => a.join(", ")),
  });

  const positionSlider = Widget.Slider({
    class_name: "position",
    draw_value: false,
    on_change: ({ value }) => (player.position = value * player.length),
    visible: player.bind("length").as((l) => l > 0),
    setup: (self) => {
      function update() {
        const value = player.position / player.length;
        self.value = value > 0 ? value : 0;
      }
      self.hook(player, update);
      self.hook(player, update, "position");
      self.poll(1000, update);
    },
  });

  const positionLabel = Widget.Label({
    class_name: "position",
    hpack: "start",
    setup: (self) => {
      const update = (_: unknown, time?: number) => {
        self.label = lengthStr(time || player.position);
        self.visible = player.length > 0;
      };

      self.hook(player, update, "position");
      self.poll(1000, update);
    },
  });

  const lengthLabel = Widget.Label({
    class_name: "length",
    hpack: "end",
    visible: player.bind("length").as((l) => l > 0),
    label: player.bind("length").transform(lengthStr),
  });

  const icon = Widget.Icon({
    class_name: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
    tooltip_text: player.identity || "",
    icon: player.bind("entry").transform((entry) => {
      const name = `${entry}-symbolic`;
      return Utils.lookUpIcon(name) ? name : FALLBACK_ICON;
    }),
  });

  const playPause = Widget.Button({
    class_name: "play-pause",
    on_clicked: () => player.playPause(),
    visible: player.bind("can_play"),
    child: Widget.Icon({
      icon: player.bind("play_back_status").transform((s) => {
        switch (s) {
          case "Playing":
            return PAUSE_ICON;
          case "Paused":
          case "Stopped":
            return PLAY_ICON;
        }
      }),
    }),
  });

  const prev = Widget.Button({
    on_clicked: () => player.previous(),
    visible: player.bind("can_go_prev"),
    child: Widget.Icon(PREV_ICON),
  });

  const next = Widget.Button({
    on_clicked: () => player.next(),
    visible: player.bind("can_go_next"),
    child: Widget.Icon(NEXT_ICON),
  });

  return Widget.Box(
    {
      class_name: "player",
      css: "padding:10px;min-width:350px;",
    },
    img,
    Widget.Box(
      {
        vertical: true,
        // hexpand: true,
      },
      Widget.Box([title, icon]),
      artist,
      Widget.Box({ vexpand: true }),
      positionSlider,
      Widget.CenterBox({
        start_widget: positionLabel,
        center_widget: Widget.Box([prev, playPause, next]),
        end_widget: lengthLabel,
      }),
    ),
  );
}

function Media() {
  return Widget.Box({
    vertical: true,
    css: "min-height: 400px; min-width: 565px;font-size:60px;", // small hack to make it visible
    visible: true,
    children: players.as((p) => {
      // if (p.length === 0) {
      //   return Widget.Label({
      //     label: "no avaiable player",
      //   });
      // }
      return p.filter((i) => i.bus_name.includes("music")).map(Play);
    }),
  });
}

export const Player = Widget.Window({
  name: "player",
  visible: false,
  child: Media(),
  keymode: "exclusive",
  setup: (self) => {
    self.keybind("q", () => {
      App.closeWindow("player");
    });
    self.keybind("l", () => {
      mpris.getPlayer("io.github.hypengw.Qcm")?.next();
    });
    self.keybind("h", () => {
      mpris.getPlayer("io.github.hypengw.Qcm")?.previous();
    });
    self.keybind("j", () => {
      audio.speaker.volume -= 0.02;
    });
    self.keybind("k", () => {
      audio.speaker.volume += 0.02;
    });
    self.keybind("space", () => {
      mpris.getPlayer("io.github.hypengw.Qcm")?.playPause();
    });
  },
});

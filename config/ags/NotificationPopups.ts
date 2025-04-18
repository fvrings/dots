const notifications = await Service.import("notifications");
import { Notification } from "types/service/notifications";
function NotificationIcon({ app_entry, app_icon, image }: Notification) {
  if (image) {
    return Widget.Box({
      css:
        `background-image: url("${image}");` +
        "background-size: contain;" +
        "background-repeat: no-repeat;" +
        "background-position: center;",
    });
  }

  let icon = "dialog-information-symbolic";
  if (Utils.lookUpIcon(app_icon)) {
    icon = app_icon;
  }

  if (app_entry && Utils.lookUpIcon(app_entry)) {
    icon = app_entry;
  }

  return Widget.Box({
    css: "color:#BEC8C8;",
    child: Widget.Icon(icon),
  });
}

function Noti(n: Notification) {
  const title = Widget.Label({
    css: "font-size:18px;color:pink;margin-left:16px;",
    class_name: "title",
    xalign: 0,
    justification: "left",
    hexpand: true,
    max_width_chars: 24,
    wrap: true,
    label: n.summary,
    use_markup: true,
  });

  const body = Widget.Label({
    css: "color:#FF9669;padding:20px;",
    class_name: "body",
    hexpand: true,
    use_markup: true,
    xalign: 0,
    max_width_chars: 24,
    justification: "left",
    label: n.body,
    wrap: true,
  });

  const actions = Widget.Box({
    class_name: "actions",
    children: n.actions.map(({ id, label }) =>
      Widget.Button({
        class_name: "action-button",
        on_clicked: () => {
          n.invoke(id);
          n.dismiss();
        },
        hexpand: true,
        child: Widget.Label(label),
      }),
    ),
  });

  return Widget.EventBox(
    {
      attribute: { id: n.id },
      on_primary_click: n.dismiss,
    },
    Widget.Box(
      {
        class_name: `notification ${n.urgency}`,
        css: "padding:12px",
        vertical: true,
      },
      Widget.Box([Widget.Box({ vertical: true }, title, body)]),
      actions,
    ),
  );
}

export function NotificationPopups(monitor = 0) {
  const list = Widget.Box({
    vertical: true,
    children: notifications.popups.map(Noti),
  });

  function onNotified(_, id: number) {
    const n = notifications.getNotification(id);
    if (n) {
      list.children = [Noti(n), ...list.children];
    }
  }

  function onDismissed(_, id: number) {
    list.children.find((n) => n.attribute.id === id)?.destroy();
  }

  list
    .hook(notifications, onNotified, "notified")
    .hook(notifications, onDismissed, "dismissed");

  return Widget.Window({
    monitor,
    name: `notifications${monitor}`,
    class_name: "notification-popups",
    anchor: ["top", "right"],
    child: Widget.Box({
      css: "min-width: 350px; min-height: 2px;font-size:18px;background-color:#333;border-radius:12px;",
      class_name: "notifications",
      vertical: true,
      child: list,
      /** this is a simple one liner that could be used instead of
                hooking into the 'notified' and 'dismissed' signals.
                but its not very optimized becuase it will recreate
                the whole list everytime a notification is added or dismissed */
      // children: notifications.bind('popups')
      //     .as(popups => popups.map(Notification))
    }),
  });
}

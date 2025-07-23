from kitty.boss import Boss


def main(args: list[str]) -> str:
    pass


from kittens.tui.handler import result_handler


@result_handler(no_ui=True)
def handle_result(
    args: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    key = args[1]
    # get the kitty window into which to paste answer
    w = boss.window_id_map.get(target_window_id)
    if w is not None:
        title = w.title.lower()
        # if "nvim" in title or "yazi" in title:
        if "nvim" in title:
            boss.call_remote_control(
                w, ("send-key", f"--match=id:{w.id}", f"alt+{key}")
            )
        else:
            match key:
                case "q":
                    boss.call_remote_control(w, ("close-window", f"--match=id:{w.id}"))
                case "h":
                    boss.active_tab.neighboring_window("left")
                case "l":
                    boss.active_tab.neighboring_window("right")
                case "j":
                    boss.active_tab.neighboring_window("down")
                case "k":
                    boss.active_tab.neighboring_window("up")

#!/usr/bin/env python
import sys
import subprocess


def run(command: str) -> str:
    res = subprocess.check_output(command, shell=True)
    return res.decode()


cmd = sys.argv[1]
res = run("hyprctl getoption decoration:active_opacity")
opacity = float(res.splitlines()[0].split()[1])
if opacity == 1.0 and cmd == "i":
    run("notify-send '🎨 overflow'")
elif opacity == 0.1 and cmd == "d":
    run("notify-send '🎨 downflow'")
elif cmd == "i":
    run(f"hyprctl keyword decoration:active_opacity {opacity+0.1}")
elif cmd == "d":
    run(f"hyprctl keyword decoration:active_opacity {opacity-0.1}")

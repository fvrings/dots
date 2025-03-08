#!/usr/bin/env python
from pwn import *

context.log_level = "debug"
context.terminal = [
    "zellij",
    "action",
    "new-pane",
    "-d",
    "right",
    "-c",
    "--",
    "bash",
    "-c",
]
filepath = "./rop"
sh = process(filepath)
# sh = remote()
elf = ELF(filepath)
sh.sendline()
# gdb.attach(sh)
sh.interactive()

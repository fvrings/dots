#!/usr/bin/env bash

tty=$(tmux display-message -p '#{pane_tty}')

pgrep_tty="${tty#/dev/}"

is_vim() {
  pgrep -t "$pgrep_tty" -x nvim >/dev/null 2>&1
}
if is_vim; then
  tmux send-keys -t "$TMUX_PANE" M-q
else
  echo 2
  tmux kill-pane
fi

#!/usr/bin/env bash

# Get pane PID
pane_pid=$(tmux display-message -p "#{pane_pid}")

# Check for Neovim process in pane's tree
if pgrep -P "$pane_pid" -af | grep -qE 'yazi|nvim|vim'; then
  # tmux display-message -d 100 'Neovim detected, M-q passed'
  tmux send-keys -t "$TMUX_PANE" M-q
else
  # No Neovim, kill the window
  tmux kill-pane
fi

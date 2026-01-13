#!/usr/bin/env bash
set -e

SESSION="nimiq-validators"
DEVNET_CONFIG="$(pwd)/dev-albatross.toml"

# Get window base index from tmux config
WINDOW_BASE=$(tmux show-options -g base-index | awk '{print $2}' || echo 0)

tmux new-session -d -s "$SESSION"

# Create and configure windows for each validator
for i in 1 2 3 4; do
  if [ "$i" -eq 1 ]; then
    # First window already exists, calculate its index
    WINDOW_INDEX=$WINDOW_BASE
  else
    # Create new window
    tmux new-window -t "$SESSION"
    WINDOW_INDEX=$(($WINDOW_BASE + i - 1))
  fi

  # Send commands to the specific window (no panes needed)
  tmux send-keys -t "$SESSION:$WINDOW_INDEX" \
    "./run-validator.sh $i" C-m
done

# Optionally, select the first window before attaching
tmux select-window -t "$SESSION:$WINDOW_BASE"

tmux attach -t "$SESSION"
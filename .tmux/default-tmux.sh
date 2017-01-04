#!/usr/bin/env bash
tmux new-session -d -s $1 -n Editor
tmux split-window -h
tmux new-window -n Testing
tmux selectw -t 1
tmux selectp -t 1
tmux -2 attach-session -d

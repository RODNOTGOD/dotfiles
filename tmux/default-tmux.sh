#!/usr/bin/env bash
tmux new-session -d -s $1 -n Editor
tmux new-window -n Debug
tmux split-window -h
tmux selectp -t 1
tmux selectw -t 1
tmux -2 attach-session -d

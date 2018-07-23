#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# MONITOR SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Monitor : Starts up tmux monitoring window with top and nvidia-smi
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: monitor [self]
#  - self : replace current tmux window
#
#--------------------------------------------------------------------------------------------------------

# Windows
if [ "$1" == "self" ]; then
    tmc -s -n Monitor -d $HOME vv
else
    tmc -n Monitor -d $HOME vv
fi

# Commands
tmux send -t Monitor.1 'top' Enter
tmux send -t Monitor.2 'watch -n0.1 nvidia-smi' Enter

# Select main window
tmux selectw -t Monitor
tmux selectp -t 1

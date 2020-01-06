# Settings
##########

# Enable True Color in Tmux 
set -g default-terminal "xterm-256color"

# Set window & pane index starting from 1
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on 

# Longer History
set-option -g history-limit 50000

# Enable Mouse Ctrl
set -g mouse on

# Fix NeoVim Related Problems
set -sa terminal-overrides ',xterm-256color:RGB'            # True Color in NVIM
set -g -a terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'   # Cursor Shape
set -g escape-time 0                                        # Fix Slow ESC-response

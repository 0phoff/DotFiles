# Settings
##########

# Enable True Color in Tmux
set -sg default-terminal "tmux-256color"
set -ga terminal-overrides ",*col*:Tc"

# Set window & pane index starting from 1
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on 

# Show pane number long enough
set -g display-panes-time 3000

# Longer History
set-option -g history-limit 50000

# Enable Mouse Ctrl
set -g mouse on

# Vim keybindings
set -g mode-keys vi

# Fix Editor Related Problems
set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'     # Cursor Shape
set -g escape-time 0                                        # Fix Slow ESC-response

# Focus events
set-option -g focus-events on

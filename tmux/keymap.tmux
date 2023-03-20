# Keymappings
#############

# Remap prefix from 'C-b' to 'C-q'
unbind C-b
set-option -g prefix C-q
bind C-q send-prefix

# Easy Reload 'Prefix-r'
unbind R
bind R source-file ~/.tmux.conf \; display 'Tmux Config Reloaded'

# Sync-panes
unbind y
bind y setw synchronize-panes

# Session chooser
unbind s
bind s popup -E "tmsc $(tmux display-message -p '#S')"

# Throwaway popup
unbind p
bind p popup bash

# Create terminal commands
unbind '"'
unbind %
unbind c
unbind `
bind w run-shell 'tmux new-window "cd \"$(tmux show-environment $(echo "TMUXPWD_#D" | tr -d %) | sed -e "s/^.*=//")\"; exec $SHELL -l"'
bind v run-shell 'tmux split-window -h "cd \"$(tmux show-environment $(echo "TMUXPWD_#D" | tr -d %) | sed -e "s/^.*=//")\"; exec $SHELL -l"'
bind h run-shell 'tmux split-window -v "cd \"$(tmux show-environment $(echo "TMUXPWD_#D" | tr -d %) | sed -e "s/^.*=//")\"; exec $SHELL -l"'

# Kill Window
bind C-w kill-window

# Terminal commands
bind c send-keys 'clear' Enter
bind r send-keys 'clear' Enter '!-2' Enter
bind ` run-shell 'monitor'
 
# Copy mode commands
unbind [
unbind -T copy-mode-vi Space
unbind -T copy-mode-vi C-e
unbind -T copy-mode-vi C-y
unbind -T copy-mode-vi L
unbind -T copy-mode-vi M
unbind -T copy-mode-vi H
bind u copy-mode
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-pipe-and-cancel 'xclip -i -selection clipboard'
bind -T copy-mode-vi u send -X scroll-up
bind -T copy-mode-vi d send -X scroll-down

# Switch Pane C-hjkl -> Work with vim
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \ | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
bind -T copy-mode-vi C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
bind -T copy-mode-vi C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
bind -T copy-mode-vi C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
bind -T copy-mode-vi C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"

# Switch Window C-M-jk
bind -n M-C-k previous-window
bind -n M-C-j next-window
bind -T copy-mode-vi M-C-k previous-window
bind -T copy-mode-vi M-C-j next-window

# Rotate panes
unbind C-o
unbind M-O
bind -n M-C-[ rotate-window -U
bind -n M-C-] rotate-window -D

# Fix Home/End
bind-key -n Home send Escape "OH"
bind-key -n End send Escape "OF"

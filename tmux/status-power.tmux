# Statusline Powerline
######################

set -g status "on"

set -g message-fg cyan
set -g message-bg brightblack
set -g message-command-fg cyan
set -g message-command-bg brightblack

set -g status-bg black
set -g status-fg white
set -g status-attr none

set -g status-justify "left"
set -g status-left-length 100
set -g status-right-length 100

set -g status-left "#{?client_prefix,#[fg=black]#[bg=white] #S #[fg=white]#[bg=black],#[fg=white,bg=brightblack] #S #[fg=brightblack]#[bg=black]}#[fg=blue,bg=black]"
set -g status-right '#{?GITMUX_REPO,#[fg=brightblack]#[bg=black]#[fg=white]#[bg=brightblack] #[fg=red]#{GITMUX_UNTRACKED} #[fg=yellow]#{GITMUX_CHANGED} #[fg=green]●#{GITMUX_STAGED} #[fg=white] #[fg=green]↑#{GITMUX_COMMITS_AHEAD} #[fg=red]↓#{GITMUX_COMMITS_BEHIND} #[fg=white] #{?GITMUX_REMOTE,⎇ #{GITMUX_BRANCH},#[fg=red]⎇ #[fg=white]#{GITMUX_BRANCH}} #[fg=black], }#[fg=brightblack]#[bg=black]#[fg=white]#[bg=brightblack] %H:%M #[fg=black]#[fg=blue,bg=black]#[fg=black,bg=blue] #U  #H '

set -g window-status-format "#[fg=black,bg=brightblack,nobold,noitalics,nounderscore] #[fg=white,bg=brightblack]#I #[fg=white,bg=brightblack,nobold,noitalics,nounderscore] #{?window_zoomed_flag,李,#{?pane_synchronized,易, }}#[fg=white,bg=brightblack]#W #[fg=brightblack,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-current-format "#[fg=black,bg=cyan,nobold,noitalics,nounderscore] #[fg=black,bg=cyan]#I #[fg=black,bg=cyan,nobold,noitalics,nounderscore] #{?window_zoomed_flag,李,#{?pane_synchronized,易, }}#[fg=black,bg=cyan]#W #[fg=cyan,bg=black,nobold,noitalics,nounderscore]"
set -g window-status-separator ""

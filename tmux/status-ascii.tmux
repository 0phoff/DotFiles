# Statusline Powerline
######################

set -g status "on"
set -g status-justify "left"
set -g status-left-length 100
set -g status-right-length 100

set -g status-left "#[fg=brightblack][#{?client_prefix,#[fg=magenta]#S,#[fg=cyan]#S}#[fg=brightblack]]╾─╼"
set -g status-right "#{?GITMUX_REPO,#[fg=brightblack][#{?GITMUX_REMOTE,#[fg=blue]⎇ #{GITMUX_BRANCH},#[fg=red]⎇ #[fg=blue]#{GITMUX_BRANCH}}#[fg=brightblack]][#[fg=green]↑#{GITMUX_COMMITS_AHEAD} #[fg=red]↓#{GITMUX_COMMITS_BEHIND}#[fg=brightblack]][#[fg=red] #{GITMUX_UNTRACKED} #[fg=yellow] #{GITMUX_CHANGED} #[fg=green] #{GITMUX_STAGED}#[fg=brightblack]]╾─╼,}#[fg=brightblack][#[fg=blue]%H:%M#[fg=brightblack]][#[fg=blue]#(acpi -b | awk -F', ' '/Battery/ { print $2 }')#[fg=brightblack]]╾─╼[#[fg=cyan]#U#[fg=brightblack]]#[fg=brightblack][#[fg=cyan]#H#[fg=brightblack]]"

set -g window-status-format "#[fg=brightblack][#[fg=blue]#I#[fg=brightblack] #{?window_zoomed_flag,李,#{?pane_synchronized,易, }}#[fg=blue]#W#[fg=brightblack]]"
set -g window-status-current-format "#[fg=brightblack][#[fg=magenta]#I#[fg=brightblack] #{?window_zoomed_flag,李,#{?pane_synchronized,易, }}#[fg=magenta]#W#[fg=brightblack]]"
set -g window-status-separator ""

#!/usr/bin/env bash
#----------------------------------------------------------------------------------------------------------------------
# Tmux Session Chooser
#----------------------------------------------------------------------------------------------------------------------
#
# Search through tmux sessions with FZF
# By 0phoff
# GPL license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: 
#   ./tmux-choose-session
#
#----------------------------------------------------------------------------------------------------------------------

length=$(tmux ls -F "#{session_name}" | awk 'length > m { m = length; } END { print m }')
options=$(tmux ls -F "\033[m#{p${length}:session_name} ▏ \033[2m#{?session_attached,, } #{session_windows} windows [#W]\033[m")

session=$(
    echo -e "$options" |
    fzf \
        --ansi --nth=1 \
        --height=100% --cycle --tiebreak=length,begin,index \
        --bind "ctrl-d:reload% tmux kill-session -t \"\$(echo {} | awk -F '\\\\s+▏' '{print \$1}')\" && echo -e \"\$(tmux ls -F '#{p${length}:session_name} ▏ \033[2m#{?session_attached,, } #{session_windows} windows [#W]\033[m')\" %" \
        --bind "ctrl-x:reload% echo -e \"\$(tmux ls -F '#{p${length}:session_name} ▏ \033[2m#{?session_attached,, } #{session_windows} windows [#W]\033[m')\" %" \
        |
    awk -F '\\s+▏' '{print $1}'
)

[ -n "$session" ] && tmux switch-client -t "$session" || exit 0

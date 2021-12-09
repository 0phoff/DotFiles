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


# Get max session name length (default to 3)
length=$(tmux ls -F "#{session_name}" | awk 'length > m { m = length; } END { print m }')
length=$(( length > 3 ? length : 3 ))


# Command strings
get_current_session="\$(tmux display -p '#{session_name}')"
kill_session="tmux kill-session -t {1}"
new_session="tmux switch-client -t \$(tmux new-session -P -F '#{session_name}' -d -c '${HOME}')"

get_sessions_inner="echo -e \"\$(tmux ls -F \"#{p${length}:session_name} ▏ \033[2m#{?#{==:#{session_name},\${TMUXCURSES}},, } #{session_windows} windows [#W]\033[m\")\""
get_sessions="TMUXCURSES=${get_current_session} bash -c '${get_sessions_inner}'"

next_session_if_cur_inner="[ {1} = \${TMUXCURSES} ] && tmux switch-client -n"
next_session_if_cur="TMUXCURSES=${get_current_session} bash -c '${next_session_if_cur_inner}'"


# Run FZF
session=$(
    eval "${get_sessions}" |
    fzf \
        --ansi --nth=1 \
        --height=100% --cycle \
        --header $'<ret>: Select session\n<c-s>: New session\n<c-d>: Kill session\n' \
        --bind "ctrl-d:reload% ${next_session_if_cur} ; ${kill_session} ; ${get_sessions} %" \
        --bind "ctrl-s:execute% ${new_session} %+abort" \
        |
    awk -F '\\s+▏' '{print $1}'
)

[ -n "$session" ] && tmux switch-client -t "$session" || exit 0

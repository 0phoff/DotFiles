declare-option -hidden str tmuxsession_old_name ''

hook global KakBegin .* %{
    evaluate-commands %sh{
        # Functions
        is_int() {
            printf %d "$1" >/dev/null 2>&1
        }

        # Get Current session name
        SESSION=$([ -n "${TMUX_PANE}" ] && tmux list-panes -t "${TMUX_PANE}" -F '#S' | head -n1)

        # Set new session name
        if is_int "${SESSION}"
        then
            tmux rename-session "$(basename ${PWD})" >/dev/null 2>&1
            echo "set-option global tmuxsession_old_name '${SESSION}'"
        fi
    }
}

hook global KakEnd .* %{
    nop %sh{
        # Reset tmux session name
        if [ -n "${kak_opt_tmuxsession_old_name}" ]
        then
            tmux rename-session "${kak_opt_tmuxsession_old_name}"
        fi
    }
}

define-command -docstring "Make tmux session rename persistent even if we quit Kakoune" tmux-persist-session-name %{
    set-option global tmuxsession_old_name ''
    nop %sh{
        is_renamed=$(tmux show -w | grep 'automatic-rename off')
        if [ -z "${is_renamed}" ]
        then
            tmux rename-window "Editor"
        fi
    }
}


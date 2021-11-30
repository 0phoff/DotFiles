plug 'kakounedotcom/prelude.kak'
plug 'kakounedotcom/connect.kak' do %{
    make install
} defer tmux %{
    define-command tmux-terminal-popup -params 1.. -shell-completion \
        -docstring 'tmux-terminal-popup <program> [<arguments>]: create a new popup terminal' \
    %{
        evaluate-commands %sh{
            tmux=${kak_client_env_TMUX:-$TMUX}
            tmux_args="display-popup -E -w 80% -h 80%"

            if [ -n "$TMPDIR" ]; then
                TMUX=$tmux tmux $tmux_args env TMPDIR="$TMPDIR" "$@" < /dev/null > /dev/null 2>&1 &
            else
                TMUX=$tmux tmux $tmux_args "${@}" < /dev/null > /dev/null 2>&1 &
            fi
        }
    }
    
    alias global popup tmux-terminal-popup
} config %{
    source "%val{config}/plug/connect/custom.kak"
    source "%val{config}/plug/connect/fzf.kak"
}

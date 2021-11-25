provide-module connect-custom-fzf %§

    require-module connect

    declare-user-mode fzf
    map global fzf f ': fzf-files<ret>'         -docstring 'Open file'
    map global fzf b ': fzf-buffers<ret>'       -docstring 'Open buffer'
    map global fzf g ': fzf-grep<ret>'          -docstring 'Search all file contents'
    map global fzf G ': fzf-ripgrep<ret>'       -docstring 'Grep word under cursor through file content'

    define-command fzf-files -docstring 'Open files with fzf' %{
        + bash -c %{
            file=$(
                fdfind --type file --hidden --follow . |
                fzf \
                    --height=100% --cycle \
                    --header $'<ret>: Open \n<c-v>: Open in vertical pane \n<c-h>: Open in horizontal pane\n<c-w>: Open in new window' \
                    --bind 'ctrl-v:execute(:send tmux-terminal-horizontal kak -c $KAKOUNE_SESSION {})+abort' \
                    --bind 'ctrl-h:execute(:send tmux-terminal-vertical kak -c $KAKOUNE_SESSION {})+abort' \
                    --bind 'ctrl-w:execute(:send tmux-terminal-window kak -c $KAKOUNE_SESSION {})+abort' \
            )

            [ -n "$file" ] && :edit "$file"
            echo    # Somehow needs this echo to close popup
        }
    }

    define-command fzf-buffers -docstring 'Open buffers with fzf' %{
        + bash -c %{
            file=$(
                :ls |
                fzf \
                    --height=100% --cycle --no-sort \
                    --header $'<ret>: Open \n<c-v>: Open in vertical pane \n<c-h>: Open in horizontal pane\n<c-w>: Open in new window\n<c-d>: Delete buffer' \
                    --bind "ctrl-v:execute(:send tmux-terminal-horizontal kak -c $KAKOUNE_SESSION -e \'buffer {}\')+abort" \
                    --bind "ctrl-h:execute(:send tmux-terminal-vertical kak -c $KAKOUNE_SESSION -e \'buffer {}\')+abort" \
                    --bind "ctrl-w:execute(:send tmux-terminal-window kak -c $KAKOUNE_SESSION -e \'buffer {}\')+abort" \
                    --bind "ctrl-d:reload(:send db {} && :ls)" \
            )

            [ -n "$file" ] && :buffer "$file"
            echo    # Somehow needs this echo to close popup
        }
    }

    define-command fzf-ripgrep-impl -hidden -params 1 %{
        + bash -c %{
            function open_file() {
                file=$(echo "$2" | cut -d':' -f1)
                line=$(echo "$2" | cut -d':' -f2)
                eval "$1 +$line '$file'"
            }

            file=$(
                rg --line-number --with-filename --follow --smart-case "$1" |
                fzf \
                    --height=100% --cycle \
                    --delimiter=: --nth=3.. \
                    --header $'<ret>: Open \n<c-v>: Open in vertical pane \n<c-h>: Open in horizontal pane\n<c-w>: Open in new window' \
                    --bind 'ctrl-v:execute(open_file ":send tmux-terminal-horizontal kak -c $KAKOUNE_SESSION" "{}")+abort' \
                    --bind 'ctrl-h:execute(open_file ":send tmux-terminal-vertical kak -c $KAKOUNE_SESSION" "{}")+abort' \
                    --bind 'ctrl-w:execute(open_file ":send tmux-terminal-window kak -c $KAKOUNE_SESSION" "{}")+abort' \
            )

            [ -n "$file" ] && open_file ":edit" "$file"
            echo    # Somehow needs this echo to close popup
        } "kak-ripgrep" "%arg{1}"
    }

    define-command fzf-grep -docstring 'Dynamically grep file contents with fzf' %{
        fzf-ripgrep-impl '.'
    }

    define-command fzf-ripgrep -docstring 'RipGrep current selection in files and show results with fzf' %{
        evaluate-commands %sh{
            if [ "$kak_val_selection_length" = "1" ]; then
                # Expand selection under cursor
                echo "execute-keys -draft '<a-i>w:fzf-ripgrep-impl %val{selections}'"
            else
                echo "fzf-ripgrep-impl '${kak_val_selection}'"
            fi
        }
    }
§

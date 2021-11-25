provide-module connect-custom-fzf %§

    require-module connect-custom
    set-option -add global connect_paths "%opt{script_connect_path}/fzf"

    declare-user-mode fzf
    map global fzf f ': fzf-files<ret>'             -docstring 'Open file'
    map global fzf b ': fzf-buffers<ret>'           -docstring 'Open buffer'
    map global fzf g ': fzf-ripgrep -m .<ret>'      -docstring 'Search file contents'
    map global fzf G ': fzf-ripgrep-cursor<ret>'    -docstring 'Search file contents for word under cursor'

    define-command fzf-files -params ..1 -file-completion -docstring %{
        fzf-files: Open files with fzf
    } %{
        + :fzf-files %arg{1}
    }

    define-command fzf-buffers -docstring %{
        fzf-buffers: Open buffers with fzf
    } %{
        + :fzf-buffers
    }

    define-command fzf-ripgrep -params 1.. -docstring %{
        fzf-ripgrep [<switches>] <regexes>...: Search file contents for <regexes>
        Switches:
            -m do not show initial rg match in red
    } %{
        + :fzf-ripgrep %arg{@}
    }

    define-command fzf-ripgrep-cursor -hidden -docstring %{
        fzf-ripgrep-cursor: Search file contents for word under cursor
    } %{
        evaluate-commands %sh{
            if [ "$kak_selection_length" = "1" ]; then
                # Expand selection under cursor
                echo "execute-keys -draft '<a-i>w:fzf-ripgre %val{selection}<ret>'"
            else
                echo "fzf-ripgrep ${kak_selection}"
            fi
        }
    }
§

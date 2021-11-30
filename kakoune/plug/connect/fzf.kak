map global user f ': require-module connect-fzf<ret>: enter-user-mode fzf<ret>' -docstring 'FZF'

provide-module -override connect-fzf %§

    require-module connect-custom
    set-option -add global connect_paths "%val{config}/plug/connect/fzf"

    declare-user-mode fzf
    map global fzf f ': fzf-files<ret>'             -docstring 'Open file'
    map global fzf F ': fzf-all-files<ret>'         -docstring 'Open hidden file'
    map global fzf b ': fzf-buffers<ret>'           -docstring 'Open buffer'
    map global fzf g ': fzf-ripgrep -m .<ret>'      -docstring 'Search file contents'
    map global fzf G ': fzf-ripgrep-cursor<ret>'    -docstring 'Search file contents for word under cursor'

    define-command fzf-files -params ..1 -file-completion -docstring %{
        fzf-files: Open files with fzf
    } %{
        + :fzf-files %arg{1}
    }

    define-command fzf-all-files -params ..1 -file-completion -docstring %{
        fzf-all-files: Open hidden files with fzf
    } %{
        + :fzf-all-files %arg{1}
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
        fzf-ripgrep-cursor: Search file contents for selection or prompt
    } %{
        evaluate-commands %sh{
            if [ "$kak_selection_length" = "1" ]; then
                echo "prompt 'regex: ' 'fzf-ripgrep %val{text}'"
            else
                echo "fzf-ripgrep ${kak_selection}"
            fi
        }
    }
§

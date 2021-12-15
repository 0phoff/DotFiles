# Change cursor color in insert mode
hook global -group theme-change-cursor ModeChange (push|pop):.*:insert %{
    set-face window PrimaryCursor "PrimaryCursorInsert"
    set-face window SecondaryCursor "SecondaryCursorInsert"
}

hook global -group theme-change-cursor ModeChange (push|pop):insert:.* %{
    unset-face window PrimaryCursor
    unset-face window SecondaryCursor
}


# Toggle Status Line and Cursor if client is not active
declare-option str last_focus_in
hook global -group theme-show-focused FocusIn .* %{
    set-option global last_focus_in %val{client}

    unset-face window StatusLine
    unset-face window StatusLineMode
    unset-face window StatusLineInfo
    unset-face window StatusLineValue
    unset-face window StatusLineOk
    unset-face window StatusLineWarn
    unset-face window StatusLineError
    unset-face window StatusLineCursor
    unset-face window PrimaryCursor
    unset-face window SecondaryCursor
    
    evaluate-commands %sh{
        if [ "${kak_mode}" = "insert" ]; then
            echo "set-face window PrimaryCursor 'PrimaryCursorInsert'"
            echo "set-face window SecondaryCursor 'SecondaryCursorInsert'"
        fi
        for client in $kak_client_list; do
            if [ "$client" != "$kak_hook_param" ]; then
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLine StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineMode StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineInfo StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineValue StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineOk StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineWarn StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineError StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window StatusLineCursor StatusLineDim'"
                echo "eval -no-hooks -client '${client}' 'set-face window PrimaryCursor PrimarySelection'"
                echo "eval -no-hooks -client '${client}' 'set-face window SecondaryCursor SecondarySelection'"
            fi
        done
    }
}

hook global -group theme-show-focused FocusOut .* %{
    set-face window StatusLine StatusLineDim
    set-face window StatusLineMode StatusLineDim
    set-face window StatusLineInfo StatusLineDim
    set-face window StatusLineValue StatusLineDim
    set-face window StatusLineOk StatusLineDim
    set-face window StatusLineWarn StatusLineDim
    set-face window StatusLineError StatusLineDim
    set-face window StatusLineCursor StatusLineDim
    set-face window PrimaryCursor PrimarySelection
    set-face window SecondaryCursor SecondarySelection
}

hook global -group theme-show-focused WinDisplay .* %{
    evaluate-commands %sh{
        if [ "$kak_client" = "$kak_opt_last_focus_in" ]; then
            echo "unset-face window StatusLine"
            echo "unset-face window StatusLineMode"
            echo "unset-face window StatusLineInfo"
            echo "unset-face window StatusLineValue"
            echo "unset-face window StatusLineOk"
            echo "unset-face window StatusLineWarn"
            echo "unset-face window StatusLineError"
            echo "unset-face window StatusLineCursor"
            echo "unset-face window PrimaryCursor"
            echo "unset-face window SecondaryCursor"
            if [ "${kak_mode}" = "insert" ]; then
                echo "set-face window PrimaryCursor 'PrimaryCursorInsert'"
                echo "set-face window SecondaryCursor 'SecondaryCursorInsert'"
            fi
        elif [ -n "$kak_opt_last_focus_in" ]; then
            echo "set-face window StatusLine StatusLineDim"
            echo "set-face window StatusLineMode StatusLineDim"
            echo "set-face window StatusLineInfo StatusLineDim"
            echo "set-face window StatusLineValue StatusLineDim"
            echo "set-face window StatusLineOk StatusLineDim"
            echo "set-face window StatusLineWarn StatusLineDim"
            echo "set-face window StatusLineError StatusLineDim"
            echo "set-face window StatusLineCursor StatusLineDim"
            echo "set-face window PrimaryCursor PrimarySelection"
            echo "set-face window SecondaryCursor SecondarySelection"
        fi
    }
}

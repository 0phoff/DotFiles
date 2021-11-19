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
    unset-face window PrimaryCursorEol
    unset-face window SecondaryCursor
    unset-face window SecondaryCursorEol
    
    evaluate-commands %sh{
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
                echo "eval -no-hooks -client '${client}' 'set-face window PrimaryCursorEol PrimarySelection'"
                echo "eval -no-hooks -client '${client}' 'set-face window SecondaryCursor SecondarySelection'"
                echo "eval -no-hooks -client '${client}' 'set-face window SecondaryCursorEol SecondarySelection'"
            fi
        done
    }
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
            echo "unset-face window PrimaryCursorEol"
            echo "unset-face window SecondaryCursor"
            echo "unset-face window SecondaryCursorEol"
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
            echo "set-face window PrimaryCursorEol PrimarySelection"
            echo "set-face window SecondaryCursor SecondarySelection"
            echo "set-face window SecondaryCursorEol SecondarySelection"
        fi
    }
}

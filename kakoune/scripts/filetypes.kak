hook global WinCreate .*(\.tex|\.latex) %{
    # Line Wrapping
    add-highlighter window/ wrap -word -indent 
}

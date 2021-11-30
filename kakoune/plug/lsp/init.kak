plug "kak-lsp/kak-lsp" do %{
    cargo install --force --locked --path .
    pip install -U 'python-lsp-server[rope,flake8,yapf,pydocstyle]'
} config %{
    map global user l ': enter-user-mode lsp<ret>' -docstring 'LSP'
    set-option global lsp_cmd "kak-lsp -s %val{session} --config %val{config}/plug/lsp/kak-lsp.toml"

    set-option global lsp_diagnostic_line_error_sign 'ﱥ '
    set-option global lsp_diagnostic_line_warning_sign ' '
    set-option global lsp_diagnostic_line_info_sign ' '
    set-option global lsp_diagnostic_line_hint_sign ' '
    set-face   global LineFlagError     "%opt{theme_color_11}"
    set-face   global LineFlagWarning   "%opt{theme_color_13}"
    set-face   global LineFlagInfo      "%opt{theme_color_10}"
    set-face   global LineFlagHint      "%opt{theme_color_10}"

    hook global WinSetOption filetype=(python) %{ lsp-enable-window }

    set-option global lsp_config %{
        [language.python.settings._]
        pylsp.configurationSources = ['flake8']
        pylsp.plugins.flake8.enabled = true
        pylsp.plugins.flake8.maxLineLength = 120
        pylsp.plugins.pyflakes.enabled = false
        pylsp.plugins.pycodestyle.enabled = false
    }
    
    hook global KakEnd .* lsp-exit
}

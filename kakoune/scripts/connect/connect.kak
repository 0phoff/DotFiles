declare-option -hidden str script_connect_path %sh{ dirname "$kak_source" }

source "%opt{script_connect_path}/fzf.kak"

provide-module connect-custom %§
    require-module connect
    set-option -add global connect_paths "%opt{script_connect_path}/connect"
§

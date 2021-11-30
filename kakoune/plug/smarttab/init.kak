declare-option -hidden str smarttab_cfg_path %sh{ dirname "$kak_source" }

plug "andreyorst/smarttab.kak" config %{
    source "%opt{smarttab_cfg_path}/editorconfig.kak"

    hook global WinSetOption filetype=.* %{ smarttab-editorconfig expandtab }
    hook global WinSetOption filetype=(makefile) noexpandtab
    hook global WinSetOption filetype=(c|cpp|typescript|javascript) %{ smarttab-editorconfig smarttab }
} defer smarttab %{
    set-option global softtabstop 4
    set-option global smarttab_default true
}

declare-option -hidden str theme_path %sh{ dirname "$kak_source" }

source "%opt{theme_path}/colors.kak"
source "%opt{theme_path}/colorscheme.kak"
source "%opt{theme_path}/statusline.kak"
source "%opt{theme_path}/hooks.kak"

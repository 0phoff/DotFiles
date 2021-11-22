#--------------------------------------------------------------------------------------------------------
#
#  ____  ____  ____  ____  _____  ____    ___  _____  _  _  ____  ____  ___
# ( ___)(  _ \(_  _)(_  _)(  _  )(  _ \  / __)(  _  )( \( )( ___)(_  _)/ __)
#  )__)  )(_) )_)(_   )(   )(_)(  )   / ( (__  )(_)(  )  (  )__)  _)(_( (_-.
# (____)(____/(____) (__) (_____)(_)\_)  \___)(_____)(_)\_)(__)  (____)\___/
#
#--------------------------------------------------------------------------------------------------------

declare-option -docstring "Default to smarttab or noexpandtab when editorconfig sets indent_style to tabs without smart_tabs" \
bool smarttab_default false


define-command smarttab-editorconfig -params 1..2 \
-docstring "smarttab-editorconfig <default-mode> [file]: Set formatting and tabbing behaviour according to editorconfig or default-mode" \
%{
    require-module smarttab
    evaluate-commands %sh{
        command -v editorconfig >/dev/null 2>&1 || { echo "fail editorconfig could not be found"; exit 1; }
        default_mode="${1}"
        file="${2:-$kak_buffile}"
        case $file in
            /*) # $kak_buffile is a full path that starts with a '/'
                printf %s\\n "remove-hooks buffer editorconfig-hooks"
                editorconfig "$file" | awk -v file="$file" -v default_mode="$default_mode" -v smarttab_default="${kak_opt_smarttab_default}" -F= -- '
                    $1 == "indent_style"             { indent_style = $2 }
                    $1 == "smart_tabs"               { smart_tabs = $2 }
                    $1 == "indent_size"              { indent_size = $2 == "tab" ? 4 : $2 }
                    $1 == "tab_width"                { tab_width = $2 }
                    $1 == "end_of_line"              { end_of_line = $2 }
                    $1 == "charset"                  { charset = $2 }
                    $1 == "trim_trailing_whitespace" { trim_trailing_whitespace = $2 }
                    $1 == "max_line_length"          { max_line_length = $2 }
                    END {
                        if (indent_style == "tab") {
                            if (smart_tabs == "true" || (smart_tabs == "" && smarttab_default == "true")) {
                                print "smarttab"
                            } else {
                                print "noexpandtab"
                            }
                        } else if (indent_style == "space") {
                            print "set-option buffer indentwidth " indent_size
                            print "expandtab"
                        } else {
                            print default_mode
                        }
                        if (indent_size || tab_width) {
                            print "set-option buffer tabstop " (tab_width ? tab_width : indent_size)
                        }
                        if (end_of_line == "lf" || end_of_line == "crlf") {
                            print "set-option buffer eolformat " end_of_line
                        }
                        if (charset == "utf-8-bom") {
                            print "set-option buffer BOM utf8"
                        }
                        if (trim_trailing_whitespace == "true") {
                            print "hook buffer BufWritePre \"" file "\" -group editorconfig-hooks %{ try %{ execute-keys -draft %{ %s\\h+$|\\n+\\z<ret>d } } }"
                        }
                        if (max_line_length && max_line_length != "off") {
                            print "set window autowrap_column " max_line_length
                            print "autowrap-enable"
                            print "add-highlighter -override window/ column %sh{ echo $((" max_line_length "+1)) } default,bright-black"
                        }
                    }
                ' ;;
        esac
    }
}

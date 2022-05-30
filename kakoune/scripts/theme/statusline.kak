# Prompt
set-option global promptfmt         '{StatusLineDim}[{StatusLineMode}%sh{echo ${kak_mode} | tr a-z A-Z}{StatusLineDim}]'

# ModeLine
set-option global modelinefmt       '{StatusLineDim}'

# LSP
set-option -add global modelinefmt '%sh{[ -n "${kak_opt_lsp_modeline_progress}${kak_opt_lsp_modeline_code_actions}" ] && echo [}{StatusLineMode}'
set-option -add global modelinefmt '%sh{
    [ -n "${kak_opt_lsp_modeline_progress}" ] && echo "羽"
    [ -n "${kak_opt_lsp_modeline_code_actions}" ] && echo " ${kak_opt_lsp_modeline_code_actions}"
}'
set-option -add global modelinefmt '{StatusLineDim}%sh{[ -n "${kak_opt_lsp_modeline_progress}${kak_opt_lsp_modeline_code_actions}" ] && echo ]}'

# [no-hooks]
set-option -add global modelinefmt  '%sh{[ "${kak_hooks_enabled}" = "false" ] && echo [}{StatusLineMode}'
set-option -add global modelinefmt  '%sh{[ "${kak_hooks_enabled}" = "false" ] && echo "ﯠ"}'
set-option -add global modelinefmt  '{StatusLineDim}%sh{[ "${kak_hooks_enabled}" = "false" ] && echo ]}'

# [recording_reg current_reg current_count]
set-option -add global modelinefmt  '%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo [}{StatusLineMode}'
set-option -add global modelinefmt  '%sh{
    [ -n "${kak_recording_reg}" ] && echo "雷${kak_recording_reg}"
    [ -n "${kak_current_reg}" ] && echo "凌${kak_current_reg}"
    [ "${kak_current_count}" != "0" ] && echo "𧻓${kak_current_count}"
}'
set-option -add global modelinefmt  '{StatusLineDim}%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo ]}'

# [selection info]
set-option -add global modelinefmt  '[{StatusLineValue}麗%val{selection_count} %sh{ echo $((${kak_selection_index} + 1))}{StatusLineDim}]'
set-option -add global modelinefmt  '╾─╼'

# [buftype or filetype]
set-option -add global modelinefmt  '[{StatusLineValue}%sh{[ "${kak_opt_filetype}" = "" ] && echo ${kak_buftype} || echo ${kak_opt_filetype}}{StatusLineDim}]'

# [status filename]
set-option -add global modelinefmt  '[{StatusLineError}%sh{[ ${kak_read_only} = "true" ] && echo ""}{StatusLineWarn}%sh{[ ${kak_modified} = "true" -o ${kak_new} = "true" ] && echo ""}{StatusLineOk}%sh{[ "${kak_read_only}${kak_modified}${kak_new}" = "falsefalsefalse" ] && echo ""} '
set-option -add global modelinefmt  '{StatusLineValue}%val{bufname}{StatusLineDim}]'

# [cursor position]
set-option -add global modelinefmt  '╾─╼'
set-option -add global modelinefmt  '[{StatusLineValue}%sh{printf "%04d" ${kak_cursor_line}} %sh{printf "%03d" ${kak_cursor_char_column}}{StatusLineDim}]'

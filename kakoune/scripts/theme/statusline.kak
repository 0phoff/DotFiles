# Prompt
set-option global promptfmt         '{StatusLineDim}[{StatusLineMode}%sh{echo ${kak_mode} | tr a-z A-Z}{StatusLineDim}]'

# ModeLine
set-option global modelinefmt       '{StatusLineDim}'

# [recording_reg current_reg current_count][selection info]
set-option -add global modelinefmt  '%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo [}{StatusLineMode}'

set-option -add global modelinefmt  '%sh{
    [ -n "${kak_recording_reg}" ] && echo "雷${kak_recording_reg}"
    [ -n "${kak_current_reg}" ] && echo "凌${kak_current_reg}"
    [ "${kak_current_count}" != "0" ] && echo "𧻓${kak_current_count}"
}'
set-option -add global modelinefmt  '{StatusLineDim}%sh{[ "${kak_recording_reg}${kak_current_reg}${kak_current_count}" != "0" ] && echo ]}'

set-option -add global modelinefmt  '[{StatusLineValue}麗%val{selection_count} %sh{ echo $((${kak_selection_index} + 1))}{StatusLineDim}]'
set-option -add global modelinefmt  '╾─╼'

# [buftype or filetype][filename status]
set-option -add global modelinefmt  '[{StatusLineValue}%sh{[ "${kak_opt_filetype}" = "" ] && echo ${kak_buftype} || echo ${kak_opt_filetype}}{StatusLineDim}]'
set-option -add global modelinefmt  '[{StatusLineError}%sh{[ ${kak_read_only} = "true" ] && echo ""}{StatusLineWarn}%sh{[ ${kak_modified} = "true" -o ${kak_new} = "true" ] && echo ""}{StatusLineOk}%sh{[ "${kak_read_only}${kak_modified}${kak_new}" = "falsefalsefalse" ] && echo ""} '
set-option -add global modelinefmt  '{StatusLineValue}%val{bufname}{StatusLineDim}]'

# [cursor position]
set-option -add global modelinefmt  '╾─╼'
set-option -add global modelinefmt  '[{StatusLineValue}%sh{printf "%04d" ${kak_cursor_line}} %sh{printf "%03d" ${kak_cursor_char_column}}{StatusLineDim}]'

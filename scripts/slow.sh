#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# SLOW SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# SLOW : show output line by line by pressing enter
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: command_with_output | slow [-o] [-n number]
#
# Flags: 
#   -o : Overwrite lines
#   -n : Number of lines to output at once
#   -h : Print help
#
#--------------------------------------------------------------------------------------------------------

# Functions
help()
{
    printf "slow usage:\n  command_with_output | slow [-o] [-n number]\n\n"
    printf "Flags:\n"
    printf "  -h : Print help\n"
    printf "  -o : Overwrite lines\n"
    printf "  -n : Number of lines to output at once\n"
    exit
}

# Parse arguments
OVERWRITE=false
LINES=1
while getopts "on:h" flag; do
    case "$flag" in
        o) OVERWRITE=true ;;
        n) LINES=$OPTARG ;;
        h) help ;;
        \?) ;;
    esac
done

if [ "$OVERWRITE" = true ]; then
    # Store current cursor position
    echo -en "\033[s"
    # Restore saved cursor position + Clear to end of Display
    OVERWRITE="\033[u\033[J"
else
    OVERWRITE=""
fi

# Check if data is piped to slow
if [ -p /dev/stdin ]; then
    lines=""
    linenum=0
    while IFS= read line; do
        # Accumulate lines of text
        if (( linenum > 0 )); then
            lines+="\n"
        fi
        lines+="$line"
        let "linenum++"

        # Output text
        if (( linenum >= LINES )); then
            echo -e "$OVERWRITE$lines"
            read -s < /dev/tty
            lines=""
            linenum=0
        fi
    done

    # Print last text
    if [ -n "$lines" ]; then
        echo -e "$OVERWRITE$lines"
        read -s < /dev/tty
    fi
else
    printf "Slow expects piped input data!\n\n"
    help
fi

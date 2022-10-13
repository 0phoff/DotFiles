#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# HUMAN READABLE TIME SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# HTIME : Convert time to days hours minutes and seconds
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage:
#   htime \d+                           # interpreted as seconds
#   htime [\d+d] [\d+h] [\d+m] [\d+s]   # each field is optional and spaces are optional as well
#
#--------------------------------------------------------------------------------------------------------

# Assert there are input arguments
if [ $# -eq 0 ]; then
    echo "Please enter a time!"
    exit 1
fi

# Merge arguments
arg=$(printf "%s" "${@}")

# Split arguments on alpha
input_time=($(grep -Eo '[[:alpha:]]+|[0-9]+' <<< "${arg}"))

# Parse input time to seconds
input_seconds=0
index=0
while [ $index -lt ${#input_time[@]} ] ; do
    num=${input_time[$index]}
    index=$((index+1))

    if [[ "${input_time[$index]}" =~ ^[a-zA-Z] ]] ; then
        unit=${input_time[$index]}
        index=$((index+1))
    else
        unit='s'
    fi

    case ${unit::1} in
        [dD] )
            input_seconds=$((input_seconds + num * 86400))
            ;;
        [hH] )
            input_seconds=$((input_seconds + num * 3600))
            ;;
        [mM] )
            input_seconds=$((input_seconds + num * 60))
            ;;
        [sS] )
            input_seconds=$((input_seconds + num))
            ;;
        *)
            echo "Unkown unit specifier: ${unit}"
            exit 2
            ;;
    esac
done

# Pretty print input_seconds as days,hours,minutes,seconds
started=0
if [ ${input_seconds} -ge 86400 ] ; then
    started=1
    num=$((input_seconds / 86400))
    input_seconds=$((input_seconds - num * 86400))
    printf "%dd " "$num"
fi

if [ ${input_seconds} -ge 3600 ] ; then
    started=1
    num=$((input_seconds / 3600))
    input_seconds=$((input_seconds - num * 3600))
    printf "%dh " "$num"
elif [ ${started} ] ; then
    printf "0h "
fi

if [ ${input_seconds} -ge 60 ] ; then
    num=$((input_seconds / 60))
    input_seconds=$((input_seconds - num * 60))
    printf "%dm " "$num"
elif [ ${started} ] ; then
    printf "0m "
fi

printf "%ds\n" "$input_seconds"

#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------
# TIMEIT SCRIPT
#----------------------------------------------------------------------------------------------------------------------
#
# Timeit Script : Will execute a command multiple times and calculate average running time
# By            bobmcn
# Modified by   0phoff
#
# https://stackoverflow.com/questions/17601539/calculate-the-average-of-several-time-commands-in-linux
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage:
#   timeit [-s] [-S] [-n loopcount] command
#
# Flags: 
#   -s : [silent mode] pipe output of command to /dev/null
#   -S : [Silent mode] only print average values
#   -n : Number of times the command shall be run
#   -h : Print help
#
# Defaults:
#   -n10
#
#----------------------------------------------------------------------------------------------------------------------

# Functions
help()
{
    printf "timeit Usage:\n  timeit [-s|S] [-n loopcount] command\n\n"
    printf "Flags:\n"
    printf "  -h : Print help\n"
    printf "  -s : [silent mode] pipe output of command to /dev/null\n"
    printf "  -S : [Silent mode] only print average values\n"
    printf "  -n : Number of times the command shall be run\n"
    exit
}

# Parse arguments
LOOP=10
SILENT=0
while getopts "n:sSh" flag; do
    case "$flag" in
        n) LOOP=$OPTARG ;;
        s) SILENT=1 ;;
        S) SILENT=2 ;;
        h)  help ;;
        \?) ;;
    esac
done
shift $((OPTIND-1))

# Remove file if it exists
rm -f /tmp/timeit.$$

# Run command LOOP times
for ((i=1 ; i<=$LOOP ; ++i)); do
    if [ "$SILENT" -gt 0 ]; then
        /usr/bin/time -f "real %e user %U sys %S" -a -o /tmp/timeit.$$ $@ &>/dev/null
    else
        /usr/bin/time -f "real %e user %U sys %S" -a -o /tmp/timeit.$$ $@
    fi

    if [ "$SILENT" -lt 2 ]; then
        tail -1 /tmp/timeit.$$
    fi
done

# Get statistics
awk '{ et += $2; ut += $4; st += $6; count++ } END {  printf "[1mAverage:[0m \n  real\t%.3f \n  user\t%.3f \n  sys\t%.3f\n", et/count, ut/count, st/count }' /tmp/timeit.$$

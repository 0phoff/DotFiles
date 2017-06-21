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
#
# Defaults:
#   -n10
#
#----------------------------------------------------------------------------------------------------------------------

# Parse arguments
LOOP=10
SILENT=0
while getopts "n:sS" flag; do
    case "$flag" in
        n) LOOP=$OPTARG ;;
        s) SILENT=1 ;;
        S) SILENT=2 ;;
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

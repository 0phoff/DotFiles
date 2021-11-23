#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# WATCH FILE SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Watch File: Watch file(s) and run a command everytime they change
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: watch_file command file
#
#--------------------------------------------------------------------------------------------------------

# Check argument
if [ $# -le 1 ]; then
    echo 'This script expects a command and at least one file to watch'
    exit 0
fi

# save arguments
cmd=$1
shift
files=( "$@" )

inotifywait -qme modify ./ |
while read -r folder event filename; do
  for f in "${files[@]}"; do
    if [ "$f" == "$filename" ]; then
      match=1
    fi
  done

  if [ -n "${match}" ]; then
    unset match
    eval "$cmd"
  fi
done

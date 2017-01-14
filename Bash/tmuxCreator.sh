#!/bin/bash
#--------------------------------------------------------------------------------------------------------
# TMUX CREATOR SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Tmux Creator : Create tmux windows with predefined layouts
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: tmuxCreator [-d directory] [-t targetWindow] [-n windowName] layoutName
# Layouts:
#   - commandrunner [cr] : 1 main split, 1 small split at bottom to run quick commands
#   - buildrunner   [br] : main split, with side split at right for automated tasks (make,server,exec)
#   - devrunner     [dr] : main split, small bottom split for quick cmd, side split for automated tasks
#
#--------------------------------------------------------------------------------------------------------

# Check argument
if [ $# -le 0 ]; then
    tmux neww -c "$PWD"
    exit 0
fi

# Parse arguments
while getopts "d:t:n:" flag; do
    case "$flag" in
        d) PWD=$OPTARG;;
        t) TARGET=$OPTARG;;
        n) NAME="-n $OPTARG";;
        \?) ;;
    esac
done
if [ ! ${PWD:0:1} = "/" ]; then
    PWD="$(pwd)/$PWD"
fi
if [ ! -d $PWD ]; then
    PWD=$(pwd)
fi
tmux setenv -g PWD $PWD
LAYOUT=${@:$OPTIND:1}

# Create new window if targetWindow is not current
if [[ -v TARGET ]]; then
    if [ $(tmux display -p "#I") = $TARGET ]; then
        tmux splitw -d  # Create at least one split or killp -a will kill the current pane
        tmux killp -a
        if [[ -v NAME ]]; then
            tmux renamew ${NAME:3}
        fi
        GOTOPATH=$PWD
    else
        tmux neww -k -t ${TARGET} ${NAME} -c "#{PWD}"
    fi
else
    tmux neww ${NAME} -c "#{PWD}"
fi

# Create corresponding layout
case $LAYOUT in
    
    [cC]ommand[rR]unner | [cC][rR] )
        tmux splitw -d -v -c "#{PWD}" -l 5
        ;;

    [bB]uild[rR]unner | [bB][rR] )
        tmux splitw -d -h -c "#{PWD}" -p 20
        ;;

    [dD]ev[rR]unner | [dD][rR] )
        tmux splitw -d -h -c "#{PWD}" -p 20
        tmux splitw -d -v -c "#{PWD}" -l 3
        ;;

esac

# Cd to GOTOPATH
if [[ -v GOTOPATH ]]; then
    cd "$GOTOPATH"
    exec bash
fi

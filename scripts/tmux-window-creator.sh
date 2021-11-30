#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# TMUX WINDOW CREATOR
#--------------------------------------------------------------------------------------------------------
#
# Tmux Window Creator : Create tmux windows with predefined layouts
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: tmux-window-creator [-d directory] [-s|-t targetWindow] [-n windowName] layoutName
# Layouts:
#   - buildrunner   [br] : 1 main split, 1 small split at bottom for automated tasks, side pane for cmds
#   - commandrunner [cr] : 1 main split, with side split at right for commands
#   - devrunner     [dr] : 1 main split, small bottom split for automated tasks, 2 side splits for cmds
#   - launchrunner  [lr] : 4 splits of equal size, used to launch and inspect tasks
#   - singlerunner  [sr] : 1 pane
#   - horizontal    [hh] : 2 equal panes, stacked
#   - vertical      [vv] : 2 equal panes, side-by-side
#
#--------------------------------------------------------------------------------------------------------

# Check argument
if [ $# -le 0 ]; then
    exit 0
fi

# Parse arguments
while getopts "d:st:n:" flag; do
    case "$flag" in
        d) PWD=$OPTARG;;
        s) TARGET=$(tmux display -p "#I");;
        t) TARGET=$OPTARG;;
        n) NAME="-n $OPTARG";;
        *) ;;
    esac
done
if [ ! ${PWD:0:1} = "/" ]; then
    PWD="$(pwd)/$PWD"
fi
if [ ! -d "$PWD" ]; then
    PWD=$(pwd)
fi
tmux setenv PWD "$PWD"
LAYOUT=${@:$OPTIND:1}

# Create new window if targetWindow is not current
if [[ -v TARGET ]]; then
    if [ $(tmux display -p "#I") = $TARGET ]; then
        tmux splitw -d  # Create at least one split or killp -a will kill the current pane
        tmux killp -a
        if [[ -v NAME ]]; then
            tmux renamew ${NAME:3}
        fi
        if [[ "$PWD" != "$(pwd)" ]]; then
            GOTOPATH=$PWD
        fi
    else
        tmux neww -k -t ${TARGET} ${NAME} -c "#{PWD}"
    fi
else
    tmux neww ${NAME} -c "#{PWD}"
fi

# Create corresponding layout
case $LAYOUT in

    [dD][eE][vV]1 )
        tmux splitw -d -h -c "#{PWD}" -p 35
        ;;

    [dD][eE][vV]2 )
        tmux splitw -h -c "#{PWD}" -p 35
        tmux splitw -d -v -c "#{PWD}" -p 50
        tmux lastp
        ;;

    [dD][eE][vV]3 )
        tmux splitw -h -c "#{PWD}" -p 35
        tmux splitw -d -v -c "#{PWD}" -p 33
        tmux splitw -d -v -c "#{PWD}" -p 50
        tmux lastp
        ;;

    # Superseded by dev1
    [cC]ommand[rR]unner | [cC][rR] )
        tmux splitw -d -h -c "#{PWD}" -p 35
        ;;

    # Superseded by dev2
    [dD]ev[rR]unner | [dD][rR] )
        tmux splitw -h -c "#{PWD}" -p 35
        tmux splitw -d -v -c "#{PWD}" -p 50
        tmux lastp
        ;;

    [lL]aunch[rR]unner | [lL][rR] )
        tmux splitw -h -c "#{PWD}" -p 50
        tmux splitw -d -v -c "#{PWD}" -p 50
        tmux lastp
        tmux splitw -d -v -c "#{PWD}" -p 50
        ;;

    [sS]ingle[rR]unner | [sS][rR] )
        ;;

    [hH]orizontal | [hH][hH] )
        tmux splitw -d -v -c "#{PWD}" -p 50
        ;;

    [vV]ertical | [vV][vV] )
        tmux splitw -d -h -c "#{PWD}" -p 50
        ;;

esac

# Cd to GOTOPATH
if [[ -v GOTOPATH ]]; then
    cd "$GOTOPATH"
    exec bash
fi

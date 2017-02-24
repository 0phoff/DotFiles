#!/bin/bash
#----------------------------------------------------------------------------------------------------------------------
# ROS INITIALISATION SCRIPT TMUX
#----------------------------------------------------------------------------------------------------------------------
#
# ROS Initialisation Script for Tmux : This script sources the setup file & creates tmux variables for use with bashrc
# By 0phoff
# MIT license
#
#----------------------------------------------------------------------------------------------------------------------
#
# Usage: rosinit [-f setupfile]
#   - default : devel/setup.bash
#
#----------------------------------------------------------------------------------------------------------------------

# Parse arguments
FILE=devel/setup.bash
while getopts "f:" flag; do
    case "$flag" in
        f) FILE=$OPTARG;;
        \?) ;;
    esac
done

# Check for input 0
if [ $FILE == "0" ]; then
    tmux setenv -u ROSSETUP
    return
fi

# Convert to Absolute path
if [ ! ${FILE:0:1} = "/" ]; then
    FILE="$PWD/$FILE"
fi

if [ -f $FILE ]; then
    # Source ROS Setup File
    source $FILE
    
    # Create TMUX Variables for bashrc
    if [ -n "$TMUX" ]; then
        tmux setenv ROSSETUP $FILE
    fi
fi

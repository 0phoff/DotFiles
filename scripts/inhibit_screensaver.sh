#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# INHIBIT SCREENSAVER
#--------------------------------------------------------------------------------------------------------
#
# Inhibit Screensaver : Prevents xscreensaver from kicking in by using xdg-screensaver suspend
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: inhibit_screensaver window_name
#
#--------------------------------------------------------------------------------------------------------

if [ $# -le 0 ]; then
	echo 'Please give a window name'
	exit 1
fi

WID=$(xwininfo -name "$1" | awk '/Window id/ {print $4}')
xdg-screensaver suspend $WID

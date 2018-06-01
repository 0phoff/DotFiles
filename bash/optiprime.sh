#!/bin/bash
#--------------------------------------------------------------------------------------------------------
# OPTIPRIME SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Optiprime : Run bumblebee the way I like
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: optiprime <application>
#   vblank_mode is set to 0 because I noticed great performance gain (prob smth wrong with my setup..)
#   use primus is better for battery life & performance
#
#--------------------------------------------------------------------------------------------------------

vblank_mode=0 optirun -b primus "$@"

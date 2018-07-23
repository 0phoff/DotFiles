#!/usr/bin/env bash

# Pad
# Setting Button keys to unused ID's, order: top left, bottom left, top right, bottom right
xsetwacom --set "Wacom Intuos S Pad pad" Button 3 "key /"
xsetwacom --set "Wacom Intuos S Pad pad" Button 1 "key ctrl"
xsetwacom --set "Wacom Intuos S Pad pad" Button 9 "key PgUp"
xsetwacom --set "Wacom Intuos S Pad pad" Button 8 "key PgDn"

# Stylus
# Set wacom to primary screen
xsetwacom --set "Wacom Intuos S Pen stylus" MapToOutput LVDS-1
# Setting Button keys to 0 -> accidental presses
xsetwacom --set "Wacom Intuos S Pen stylus" Button 2 "0"
xsetwacom --set "Wacom Intuos S Pen stylus" Button 3 "button 3"

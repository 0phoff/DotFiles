#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# TOUCHPAD OFF
#--------------------------------------------------------------------------------------------------------
#
# Touchpad Off : Disable trackpad if mouse is detected
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: touchpad_off [0|1]
#
#--------------------------------------------------------------------------------------------------------
MOUSE=A4Tech
TOUCHPAD='SynPS/2 Synaptics TouchPad'
TOUCHPAD='DLL07BE:01 06CB:7A13 Touchpad'

if [ $# -ne 1 ]; then
    output=`lsusb | grep "$MOUSE" | wc -l`
    if [ "$output" -eq "1" ]; then
        value=0
    else
        value=1
    fi
else
    value=$1
fi

xinput --set-prop "$TOUCHPAD" 'Device Enabled' $value

if [ "$value" -eq "0" ]; then
    echo Touchpad Disabled
else
    echo Touchpad Enabled
fi

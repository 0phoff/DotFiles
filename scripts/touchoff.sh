#!/bin/bash
# thank you: http://www.linuxquestions.org/questions/debian-26/shmconfig-in-debian-645503/#post3838794
# script to turn off touchpad if mouse present at login
# synclient is the synaptic utility to manage the touchpad
# grep the "lsusb" output and do a wordcount on number of lines with "Logitech" which should = 1 if a Logitech mouse is present
#
# Obviously the "Logitech" should be replaced with your brand of mouse, and perhaps be more exact in case you have other USB devices that have similar names

if [ $# -ne 1 ]; then
    output=`lsusb | grep A4Tech | wc -l`
    if [ "$output" -eq "1" ]; then
        value=0
    else
        value=1
    fi
else
    value=$1
fi

xinput --set-prop 'ETPS/2 Elantech Touchpad' 'Device Enabled' $value

if [ "$value" -eq "0" ]; then
    echo Touchpad Disabled
else
    echo Touchpad Enabled
fi

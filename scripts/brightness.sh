#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# BRIGHTNESS CONTROL SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Brightness Control : Control your brightness and send notification
# Modified by   0phoff
#
# Be sure to install dunst from source and also install the dunstify utility:
#    > make
#    > sudo make install
#    > make dunstify
#    > sudo install -Dm755 dunstify /usr/local/bin/dunstify
#
# Enable this script to be run as sudo without password:
#    > https://ubuntuforums.org/showthread.php?t=2340223<Paste>
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: xrandr up|down|set|mute [percent]
#
#--------------------------------------------------------------------------------------------------------
NOTIF_ID=6667
DEV=intel_backlight

BRIGHT_PATH="/sys/class/backlight/$DEV"
MAX=$(cat "$BRIGHT_PATH/max_brightness")

function get_brightness {
    local bright=$(cat "$BRIGHT_PATH/brightness")
    echo $((100 * $bright / $MAX))
}

function set_brightness {
    if [ "$1" -gt "100" ]; then
        $1=100
    elif [ "$1" -lt "0" ]; then
        $1=0
    fi 

    local bright=$(($1 * $MAX / 100))
    echo $bright > "$BRIGHT_PATH/brightness"
}

function send_notification {
    level=$(get_brightness)
    bar="$(seq -s "─" $(($level / 5)) | sed 's/[0-9]//g')"
    dunstify -i display-brightness-symbolic -t 500 -r $NOTIF_ID -u normal "$level   $bar"
}

case $1 in
    set)
        if [ $# -ge 2 ]; then
            set_brightness $2
            send_notification
        fi
        ;;
    up)
        set_brightness $(($(get_brightness) + ${2:-5}))
	send_notification
	;;
    down)
        set_brightness $(($(get_brightness) - ${2:-5}))
	send_notification
	;;
esac

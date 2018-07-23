#!/usr/bin/env bash
#--------------------------------------------------------------------------------------------------------
# VOLUME CONTROL SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Volume Control : Control your volume with amixer and send notification
# By		sebastiencs
# Modified by   0phoff
#
# https://gist.github.com/sebastiencs/5d7227f388d93374cebdf72e783fbd6a
#
# Be sure to install dunst from source and also install the dunstify utility:
#    > make
#    > sudo make install
#    > make dunstify
#    > sudo install -Dm755 dunstify /usr/local/bin/dunstify
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: volume up|down|set|mute [percent]
#
#--------------------------------------------------------------------------------------------------------
NOTIF_ID=6666

function get_volume {
    amixer -M get Master | awk -F"[][%]" '/dB/ { print $2 }'
}

function is_mute {
    amixer -M get Master | awk -F"[][]" '/dB/ { print $6 }' | grep off > /dev/null
}

function send_notification {
    if is_mute ; then
        dunstify -i audio-volume-muted-symbolic -t 500 -r $NOTIF_ID -u normal "Mute"
    else
	volume=$(get_volume)
	bar="$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')"
        dunstify -i audio-volume-high-symbolic -t 500 -r $NOTIF_ID -u normal "$volume   $bar"
    fi
}

case $1 in
    set)
        if [ $# -ge 2 ]; then
	    amixer -D pulse set Master on > /dev/null
	    amixer -M sset Master $2% > /dev/null
        fi
        ;;
    up)
	amixer -D pulse set Master on > /dev/null
	amixer -M sset Master ${2:-5}%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -M sset Master ${2:-5}%- > /dev/null
	send_notification
	;;
    mute)
	amixer -q -D pulse sset Master toggle > /dev/null
	send_notification
	;;
esac

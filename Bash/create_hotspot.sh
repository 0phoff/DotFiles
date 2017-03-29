#!/bin/sh
#--------------------------------------------------------------------------------------------------------
# CREATE HOTSPOT SCRIPT
#--------------------------------------------------------------------------------------------------------
#
# Create Hotspot : Create a hotspot
# By 0phoff
# MIT license
#
#--------------------------------------------------------------------------------------------------------
#
# Usage: sudo create_hp [-s ssid] [-p password ][-W|-w hostname]
# Extra commands :
#   - create_ap --list-running                  list running hotspots
#   - create_ap --list-client $ACCESSPOINT      list connected clients to certain hotspot
#
#--------------------------------------------------------------------------------------------------------

# Default Values
WLAN="wlp3s0"
ETH="enp4s0f2"
SSID="gt_AP"
PWD="gtWins00"
WAIT="raspberrypi"
WAITENABLE=false

# Functions
help()
{
    printf "Create Hotspot Usage:\n  sudo create_hotspot [-s ssid] [-p password] [-W|-w hostname]\n\n"
    printf "Flags:\n"
    printf "  -s ssid [optional]\tSSID of the hotspot (default: $SSID)\n"
    printf "  -p pwd  [optional]\tPassword of the hotspot (default: $PWD)\n"
    printf "  -w host [optional]\tWait for connection of device with certain hostname\n"
    printf "  -W      [optional]\tWait for connection of device with hostname $WAIT\n"
    exit
}

# Parse arguments
while getopts ":s:p:w:Wh" flag; do
    case "$flag" in
        s)  SSID=$OPTARG
            ;;
        p)  PWD=$OPTARG
            ;;
        w)  WAITENABLE=true
            WAIT=$OPTARG
            ;;
        W)  WAITENABLE=true
            ;;
        h)  help
            ;;
        *)  ;;
    esac
done

# Check if create_ap command exists
command -v create_ap >/dev/null && CMDEXISTS=1 || CMDEXISTS=0
if [ "$CMDEXISTS" -eq 0 ]; then
    printf "Please install the create_ap package to use this script\n\n"
    help
fi

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    printf "Please run this script as root\n\n"
    help
fi

# Delete existing hotspot
create_ap --stop $WLAN &>/dev/null

# Create hotspot
create_ap $WLAN $ETH $SSID $PWD --daemon &>/dev/null
printf "\nCreated AP\n  ssid:\t$SSID \n  pwd:\t$PWD\n"

# Get AP name
AP=""
while [ "$AP" = "" ]; do
    AP="$(create_ap --list-running | grep $WLAN | cut -d' ' -f3)"
    AP=${AP:1:${#AP}-2}
done
printf "  ap:\t$AP\n"

# Wait for connection
if [ $WAITENABLE = true ]; then
    printf "\nWaiting for connection of \e[1m$WAIT\e[0m..."
    IP=""
    while [ "$IP" = "" ]; do
        IP="$(create_ap --list-client $AP | grep $WAIT | grep -o 192\\.168\\.[0-9]\\+\\.[0-9]\\+)"
    done
    printf "\r\e[1m$WAIT\e[0m connected:  $IP\n"
fi

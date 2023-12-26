#!/bin/bash

# If powerprofilesctl is not installed, warn and exit
if ! command -v powerprofilesctl &> /dev/null; then
    echo "powerprofilesctl not installed"
    exit
fi

case $1 in
    power-saver) powerprofilesctl set power-saver ;;
    balanced) powerprofilesctl set balanced ;;
    performance) powerprofilesctl set performance ;;
    up)
        case $(powerprofilesctl get) in
            power-saver) powerprofilesctl set balanced ;;
            balanced) powerprofilesctl set performance ;;
            performance) exit ;;
        esac
    ;;
    down)
        case $(powerprofilesctl get) in
            power-saver) exit ;;
            balanced) powerprofilesctl set power-saver ;;
            performance) powerprofilesctl set balanced ;;
        esac
    ;;
    "")
        PS3="Select power profile: "
        select powerprofile in power-saver balanced performance; do
            powerprofilesctl set $powerprofile && break
        done
        PS3=""
        echo "Power profile set to $powerprofile"
    ;;
esac

# "custom/power_profile": {
#     "format": "({})",
#     "exec": "powerprofilesctl get",
#     "interval": 10,
#     "signal": 3,
#     "on-click": "$HOME/.local/bin/pprofile.sh up",
#     "on-click-right": "$HOME/.local/bin/pprofile.sh down"
# },
#
# Signal 3 refreshes this custom waybar indicator for power profile
# Add the above json block to your waybar config to use this script properly
kill -s RTMIN+3 $(pgrep waybar)

#!/bin/bash
source "$(dirname "$0")/config.env"
UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")
LOGFILE="$(dirname "$0")/logs/updates.log"

if [ -n "$UPDATES" ]; then
    zenity --question --width=300 --title="System Updates" --text="Updates available!\nDo you want to install them now?"

    if [ $? -eq 0 ]; then
        gnome-terminal -- bash -c "sudo apt update && sudo apt upgrade -y; exec bash"
    fi
else
    zenity --info --width=300 --title="System Updates" --text="Your system is up-to-date."
fi

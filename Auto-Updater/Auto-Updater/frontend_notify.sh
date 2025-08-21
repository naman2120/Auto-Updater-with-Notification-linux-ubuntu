#!/bin/bash

# Check for updates
updates=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." )

# If updates found, show them in GUI popup
if [ -n "$updates" ]; then
    zenity --info --width=400 --height=300 --title="System Updates Available" --text="Updates Available:\n$updates"
else
    zenity --info --title="System Updates" --text="Your system is up to date!"
fi

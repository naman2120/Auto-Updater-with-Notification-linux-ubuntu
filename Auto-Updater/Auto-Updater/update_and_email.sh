#!/bin/bash

# Accept email address as argument
TO="$1"

# Fetch list of updates
updates=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." )

if [ -n "$updates" ]; then
    echo -e "Subject: System Update Notification\n\nThe following packages can be upgraded:\n\n$updates" | msmtp "$TO"
else
    echo -e "Subject: System Update Notification\n\nYour system is fully up to date. No packages to upgrade." | msmtp "$TO"
fi  


#!/bin/bash
source "$(dirname "$0")/config.env"
UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")
LOGFILE="$(dirname "$0")/logs/updates.log"

if [ -n "$UPDATES" ]; then
  echo -e "$(date):\n$UPDATES\n" >> "$LOGFILE"
else
  echo -e "$(date):\nSystem is up-to-date.\n" >> "$LOGFILE"
fi

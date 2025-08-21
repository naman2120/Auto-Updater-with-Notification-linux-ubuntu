#!/bin/bash
source "$(dirname "$0")/config.env"
LOGFILE="$(dirname "$0")/logs/updates.log"
EMAIL_CONTENT=$(tail -n 50 "$LOGFILE")

echo -e "Subject: Daily System Update Report\n\n$EMAIL_CONTENT" |     msmtp --from=$FROM_EMAIL -t $TO_EMAIL

#!/bin/bash

tempfile=$(mktemp)

dialog --title "Email Scheduler" --form "Enter Email and Time" 15 60 2 \
    "Recipient Email:" 1 1 "" 1 20 40 0 \
    "Time (HH:MM 24hr):" 2 1 "" 2 20 5 0 \
    2> "$tempfile"

recipient=$(sed -n 1p "$tempfile")
time=$(sed -n 2p "$tempfile")
rm "$tempfile"

echo "$recipient" > ~/.auto_updater_email
echo "$time" > ~/.auto_updater_time

dialog --msgbox "Email will be sent to $recipient at $time daily." 7 50

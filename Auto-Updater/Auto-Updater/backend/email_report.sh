#!/bin/bash

# Read the recipient email
EMAIL_FILE="$HOME/.auto_updater_email"

if [[ ! -f "$EMAIL_FILE" ]]; then
    echo "No email address saved. Exiting." >&2
    exit 1
fi
    
EMAIL=$(cat "$EMAIL_FILE")

# Call the update_and_email script with the saved email
bash "$HOME/Auto-Updater/update_and_email.sh" "$EMAIL"


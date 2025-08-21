#!/bin/bash

# Function to show available upgrades
show_upgrades() {
  upgrades=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | cut -d'/' -f1)
  if [[ -z "$upgrades" ]]; then
    dialog --msgbox "🎉 Your system is already up to date!" 8 50
  else
    dialog --title "📦 Available Upgrades" --msgbox "The following packages can be upgraded:\n\n$upgrades\n\nPress Back to return to the menu." 20 70
  fi
  show_menu  # Return to the menu after displaying the info
}

# Function to show average time required for updates
show_avg_time() {
  avg_time=$(uptime -p)
  dialog --msgbox "⏱ Average time to update your system: $avg_time\n\nPress Back to return to the menu." 8 50
  show_menu  # Return to the menu after displaying the info
}

# Function to show the benefits of updating
show_benefits() {
  dialog --msgbox "✅ Benefits of Updating:\n  - Improved security\n  - Bug fixes\n  - New features\n\nPress Back to return to the menu." 8 50
  show_menu  # Return to the menu after displaying the info
}

# Function to show size of updates
show_update_size() {
  update_size=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | awk '{print $2}' | sed 's/,//g' | awk '{s+=$1} END {print s}')
  dialog --msgbox "📦 Total size of updates: $update_size MB\n\nPress Back to return to the menu." 8 50
  show_menu  # Return to the menu after displaying the info
}

# Function to show the menu page with buttons
show_menu() {
  dialog --title "🔧 Auto-Updater Menu" \
  --menu "Choose an option:" 20 70 5 \
  1 "Available Upgrades" \
  2 "Average Time for Updates" \
  3 "Benefits of Updating" \
  4 "Size of Updates" \
  5 "Go to Schedule Email Page" \
  2>tempfile

  choice=$(<tempfile)

  case $choice in
    1) show_upgrades ;;
    2) show_avg_time ;;
    3) show_benefits ;;
    4) show_update_size ;;
    5) schedule_email_time ;;
    *) clear ;;
  esac
}

# Function to handle email and time scheduling
schedule_email_time() {
  tempfile=$(mktemp 2>/dev/null) || tempfile=/tmp/test$$

  # Show full-screen dialog form for email and time
  dialog --backtitle "Linux Auto-Updater Scheduler" \
  --title "📧 Schedule Update Email" \
  --form "Enter the email and time to receive daily update reports" \
  22 70 0 \
  "Recipient Email:" 1 1 "" 1 25 40 0 \
  "Time (HH:MM):"     2 1 "" 2 25 5 0 \
  2> "$tempfile"

  # Check if user pressed Cancel
  if [ $? -ne 0 ]; then
    rm -f "$tempfile"
    clear
    echo "❌ Cancelled by user."
    exit 1
  fi

  # Read inputs
  recipient=$(sed -n 1p "$tempfile")
  time=$(sed -n 2p "$tempfile")
  rm -f "$tempfile"

  # Validate email and time
  if [[ -z "$recipient" || -z "$time" ]]; then
    dialog --msgbox "Both email and time are required!" 8 40
    clear
    exit 1
  fi

  if ! [[ "$time" =~ ^([01][0-9]|2[0-3]):[0-5][0-9]$ ]]; then
    dialog --msgbox "Invalid time format. Use HH:MM (24-hour)." 8 50
    clear
    exit 1
  fi

  # Save email to file
  echo "$recipient" > ~/.auto_updater_email

  # Extract hour and minute
  hour="${time%%:*}"
  minute="${time##*:}"

  # Set up cron job
  (crontab -l 2>/dev/null | grep -v "email_report.sh" ; echo "$minute $hour * * * bash $HOME/Auto-Updater/backend/email_report.sh") | crontab -

  # Show confirmation message
  dialog --msgbox "✅ Email scheduled at $time daily to $recipient" 8 50

  # Show list of upgradable packages
  updates=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | cut -d'/' -f1)

  # Display the list of upgradable packages in dialog box
  if [[ -z "$updates" ]]; then
    dialog --msgbox "🎉 Your system is already up to date!" 8 50
  else
    dialog --title "📦 Pending Updates" --msgbox "The following packages can be upgraded:\n\n$updates" 20 70
  fi

  # Clear the terminal screen after displaying
  clear
}

# Start the script by showing the menu page
show_menu
 

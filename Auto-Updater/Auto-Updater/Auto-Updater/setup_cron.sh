#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
(crontab -l 2>/dev/null; echo "0 */6 * * * $SCRIPT_DIR/updater.sh") | crontab -
(crontab -l 2>/dev/null; echo "5 */6 * * * $SCRIPT_DIR/notifier.sh") | crontab -
(crontab -l 2>/dev/null; echo "0 10 * * * $SCRIPT_DIR/email_report.sh") | crontab -
echo "Cron jobs scheduled for every 6 hours and daily email at 10:00 AM."

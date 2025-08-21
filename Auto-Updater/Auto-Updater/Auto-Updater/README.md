# Auto-Updater with Notification GUI

## Overview
This tool checks for available updates on Ubuntu using `apt list --upgradable`.
It provides GUI notifications using Zenity and sends daily email reports.

## Components
- `updater.sh`: Checks for updates and logs them.
- `notifier.sh`: GUI-based notifier.
- `email_report.sh`: Sends email with update info.
- `config.env`: Configuration file for email settings.
- `setup_cron.sh`: Sets up cron jobs.

## Setup Instructions
1. Edit `config.env` with your email settings.
2. Make all scripts executable:
   ```bash
   chmod +x *.sh
   ```
3. Run `./setup_cron.sh` to install cron jobs.
4. Ensure `zenity` and `ssmtp` or `msmtp` are installed.
5. Logs are stored in `logs/updates.log`.

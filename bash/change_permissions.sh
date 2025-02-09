#!/bin/bash

LOG_DIR="$HOME/.permissionsLog"

# Check if the log directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Log directory not found. Creating $LOG_DIR..."
    mkdir -p "$LOG_DIR"
else
    echo "Log directory found: $LOG_DIR"
fi

LOGFILE="$LOG_DIR/permissions_log_$(date +%F_%T).txt"


if [ -z "$1" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

TARGET_DIR="$1"


if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Confirmation prompt
read -p "Are you sure you want to change permissions in '$TARGET_DIR'? (y/N) " CONFIRM
if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
    echo "Operation canceled."
    exit 0
fi

# Change directory permissions (755: rwxr-xr-x)
echo "Changing directory permissions to 755..." | tee -a "$LOGFILE"
find "$TARGET_DIR" -type d -exec chmod 755 {} \; -exec echo "Directory: {} -> 755" >> "$LOGFILE" \;

# Change file permissions (444: r--r--r--)
echo "Changing file permissions to 444..." | tee -a "$LOGFILE"
find "$TARGET_DIR" -type f ! -name "*.sh" -exec chmod 444 {} \; -exec echo "File: {} -> 444" >> "$LOGFILE" \;

echo "Permissions changed successfully in '$TARGET_DIR'. Log saved to $LOGFILE."

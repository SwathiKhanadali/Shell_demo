#!/bin/bash

# Path to the log file
LOG_FILE="/var/log/syslog"  # You can change this to your desired log

# Size threshold in KB
THRESHOLD=500

# Temp file to store the previous size
TEMP_FILE="/tmp/log_size.tmp"

# Get current size of log file in KB
CURRENT_SIZE=$(du -k "$LOG_FILE" | cut -f1)

# If temp file doesn't exist, create and store current size
if [ ! -f "$TEMP_FILE" ]; then
    echo "$CURRENT_SIZE" > "$TEMP_FILE"
    echo "Initial size stored: $CURRENT_SIZE KB"
    exit 0
fi

# Read previous size
PREV_SIZE=$(cat "$TEMP_FILE")

# Calculate size difference
DIFF=$((CURRENT_SIZE - PREV_SIZE))

# Check if difference is greater than threshold
if [ "$DIFF" -gt "$THRESHOLD" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - WARNING: Log file has grown by $DIFF KB which exceeds $THRESHOLD KB"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Log file growth is normal ($DIFF KB)"
fi

# Update temp file with current size
echo "$CURRENT_SIZE" > "$TEMP_FILE"


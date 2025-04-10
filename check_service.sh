#!/bin/bash

SERVICE="nginx"
LOGFILE="/tmp/${SERVICE}_healthcheck.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

if systemctl is-active --quiet $SERVICE
then
    echo "$TIMESTAMP - $SERVICE is running fine." >> $LOGFILE
else
    echo "$TIMESTAMP - $SERVICE is down. Restarting..." >> $LOGFILE
    systemctl restart $SERVICE
    echo "$TIMESTAMP - $SERVICE restarted." >> $LOGFILE
fi

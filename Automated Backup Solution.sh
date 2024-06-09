#!/bin/bash

SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
LOG_FILE="/path/to/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Perform the backup
tar -czf $BACKUP_DIR/backup_$TIMESTAMP.tar.gz $SOURCE_DIR

# Check if the backup was successful
if [ $? -eq 0 ]; then
  echo "$TIMESTAMP: Backup successful" >> $LOG_FILE
else
  echo "$TIMESTAMP: Backup failed" >> $LOG_FILE
fi
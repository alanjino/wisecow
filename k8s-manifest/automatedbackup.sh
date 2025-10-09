#!/bin/bash

SOURCE_DIR="/home/ubuntu/github/wisecow/k8s-manifest"
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
LOCAL_BACKUP="/home/ubuntu/github/$BACKUP_NAME"
# REMOTE_USER="username"
# REMOTE_HOST="remote.server.com"
# REMOTE_DIR="/path/to/remote/backup"
LOG_FILE="backup_report.log"

echo "Backup started at $(date)" | tee -a $LOG_FILE

# Create archive
tar -czf $LOCAL_BACKUP -C "$(dirname $SOURCE_DIR)" "$(basename $SOURCE_DIR)"
if [ $? -ne 0 ]; then
  echo "❌ Failed to create archive" | tee -a $LOG_FILE
  exit 1
fi

# Transfer using scp
# scp $LOCAL_BACKUP ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_DIR}
# if [ $? -eq 0 ]; then
#   echo "✅ Backup successfully transferred" | tee -a $LOG_FILE
# else
#   echo "❌ Backup transfer failed" | tee -a $LOG_FILE
# fi

# Cleanup
# rm -f $LOCAL_BACKUP
echo "Backup finished at $(date)" | tee -a $LOG_FILE


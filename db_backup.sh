#!/bin/bash
# Name: db_backup.sh
# Author: Steve Minor
# Date: 03/07/2017
# Description: Creates a rotating set of DB backups with mysqldump and crontab

# Replace these variables
DB_USER=root
DB_PASS=root
DB_NAME=sminor_wordpress
NUM_BACKUPS=10
BACKUP_DIR=./backups

NOW="$(date +%m_%d_%Y+%H:%M:%S)"

# Create the backup
echo "Creating backup: $DB_NAME-$NOW.sql"
mysqldump $DB_NAME -p$DB_PASS -u$DB_USER --add-drop-table> "./backups/$DB_NAME-$NOW.sql"

# Remove all but the most recent backups, depending on number
cd $BACKUP_DIR
old_set=$(ls -t | awk -v awk_num_backups=$NUM_BACKUPS 'NR>awk_num_backups')
if [ "$old_set" ]
then
    rm $old_set
fi

# Edit the user cron jobs with the following
# crontab -eu <USER>
# To have the task run daily at midnight, enter
# 0 0 * * * /path_to_script/db_backup.sh 
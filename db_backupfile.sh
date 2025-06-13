#!/bin/bash

DB_NAME="mydb"
BACKUP_DIR="/home/ubuntu/backup/"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mysqldump -u root -p $DB_NAME > $BACKUP_DIR/$DB_NAME-$DATE.sql
echo "DATABASE BACKUP DONE TO: $BACKUP_DIR/$DB_NAME-$DATE.sql"

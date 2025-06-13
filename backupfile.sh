#!/bin/bash

SOURCE="/home/ubuntu/mydata"
DESTINATION="/home/ubuntu/backup/"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p $DESTINATION/$DATE
cp -r $SOURCE $DESTINATION/$DATE
echo "BACKUP COMPLETED ON $DATE"



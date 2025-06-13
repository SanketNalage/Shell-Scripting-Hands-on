#!/bin/bash

SERVICE="nginx"

if systemctl is-active --quiet $SERVICE; then
	echo "$SERVICE is running"
else
	echo "$SERVICE is not running"
	sudo systemctl start $SERVICE
fi

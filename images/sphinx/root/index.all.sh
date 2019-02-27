#!/bin/bash

LOG_FILE=/var/log/sphinx/sphinx.all.cron.log

echo -e "\n$(date) $0" >> $LOG_FILE 2>&1

/usr/local/bin/indexer --all --rotate >> $LOG_FILE 2>&1

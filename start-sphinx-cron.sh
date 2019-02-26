#!/usr/bin/env bash

LOG_FILE=$(pwd)/logs/sphinx/sphinx-delta-cron.log
echo sphinx.delta.cron.log > "$LOG_FILE"
chmod 777 "$LOG_FILE"

(crontab -l ; echo "* * * * * /usr/local/bin/docker exec -t sphinx bash /root/index.delta.sh >> $LOG_FILE 2>&1") | crontab -

LOG_FILE=$(pwd)/logs/sphinx/sphinx-all-cron.log
echo sphinx.all.cron.log > "$LOG_FILE"
chmod 777 "$LOG_FILE"

(crontab -l ; echo "*/5 * * * * /usr/local/bin/docker exec -t sphinx bash /root/index.all.sh >> $LOG_FILE 2>&1") | crontab -
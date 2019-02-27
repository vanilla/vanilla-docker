#!/usr/bin/env bash

installed=$(crontab -l | grep index.delta.sh | wc -l)

if [ $installed -gt 0 ]; then
    echo -e "Sphinx cron jobs seem already installed!\nCheck: crontab -l"
else
    (crontab -l ; echo "* * * * * /root/index.delta.sh") | crontab -
    (crontab -l ; echo "*/5 * * * * /root/index.all.sh") | crontab -
fi

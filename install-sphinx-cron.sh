#!/usr/bin/env bash

(crontab -l ; echo "* * * * * /usr/local/bin/docker exec -t sphinx bash /root/index.delta.sh") | crontab -

(crontab -l ; echo "*/5 * * * * /usr/local/bin/docker exec -t sphinx bash /root/index.all.sh") | crontab -
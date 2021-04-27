#!/bin/bash

# Start rsyslogd
rsyslogd
# Send syslog to docker logs
tail -f -n0 /var/log/syslog &
# Start php-fpm
php-fpm

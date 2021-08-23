#!/bin/ash

# Reload certificates so that everything in /usr/local/share/ca-certificates is loaded.
update-ca-certificates

# Start rsyslogd
rsyslogd

# Send syslog to docker logs
tail -f -n0 /var/log/syslog &

if [[ -z "${PHP_DEBUG}" ]]; then
  php-fpm &
else
  php-fpm -d xdebug.idekey="PHPSTORM" \
        -d xdebug.mode="debug,develop,profile,trace" \
        -d xdebug.start_with_request="yes" \
        -d xdebug.client_host="host.docker.internal" &
fi
export PHP_FPM_PID=$!

_exit() {
  kill -QUIT "$PHP_FPM_PID"
  exit 0
}

trap _exit SIGTERM SIGQUIT

wait "$PHP_FPM_PID"

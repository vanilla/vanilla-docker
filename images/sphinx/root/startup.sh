#!/bin/bash

until mysql -h"database" -u"root" -e"quit"; do
  sleep 1
done

>&2 echo "MySQL is now available."

socat tcp-l:9399,fork system:/root/listen.9399.sh &

indexer --all && searchd --nodetach

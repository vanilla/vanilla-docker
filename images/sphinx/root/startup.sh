
#!/bin/bash

sed -i 's/{MYSQL_HOST}/'"$MYSQL_HOST"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf
sed -i 's/{MYSQL_USER}/'"$MYSQL_USER"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf
sed -i 's/{MYSQL_DATABASE}/'"$MYSQL_DATABASE"'/g' /usr/local/etc/sphinx/conf.d/sphinx.conf

until mysql -h"database" -u"root" -e"quit"; do
  sleep 1
done

>&2 echo "MySQL is now available."

socat tcp-l:9399,fork system:/root/listen.9399.sh &

service crond start && indexer --all && searchd --nodetach



#!/bin/bash

until mysql -h"db" -u"root" -e"quit"; do
  sleep 1
done

>&2 echo "MySQL is now available."
indexer --all && searchd --nodetach

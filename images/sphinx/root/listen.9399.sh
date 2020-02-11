#!/bin/bash

#read MESSAGE
#echo "PID: $$"
#echo "$MESSAGE"

echo -e "\n$(date) $0"

indexer --all --rotate

echo "Sphinx reindexed."

#!/bin/bash

#read MESSAGE
#echo "PID: $$"
#echo "$MESSAGE"

echo -e "\n$(date) $0"

indexer --rotate --all

echo "Sphinx reindexed."

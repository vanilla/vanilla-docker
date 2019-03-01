#!/bin/bash

LOG_FILE=/var/log/sphinx/sphinx.delta.cron.log

echo -e "\n$(date) $0" >> $LOG_FILE 2>&1

/usr/local/bin/indexer vanilla_dev_Discussion_Delta \
        vanilla_dev_Comment_Delta \
        vanilla_dev_KnowledgeArticle_Delta \
        vanilla_dev_KnowledgeArticleDeletsed_Delta --rotate >> $LOG_FILE 2>&1
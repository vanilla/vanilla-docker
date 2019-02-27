#!/bin/bash

echo -e "\n$(date) $0"

indexer vanilla_dev_Discussion_Delta vanilla_dev_Comment_Delta vanilla_dev_KnowledgeArticle_Delta vanilla_dev_KnowledgeArticleDeleted_Delta --rotate

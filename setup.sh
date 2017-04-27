#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# Loopback 192.0.2.1 to our host (much like 127.0.0.1)
# See http://stackoverflow.com/questions/22944631/how-to-get-the-ip-address-of-the-docker-host-from-inside-a-docker-container#answer-39026136
# See https://en.wikipedia.org/wiki/Reserved_IP_addresses#IPv4
ifconfig lo0 alias 192.0.2.1

# https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-file-as-a-data-volume#creating-and-mounting-a-data-volume-container
docker volume create --name=datastorage --label="Persistent data storage"

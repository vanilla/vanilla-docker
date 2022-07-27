#!/usr/bin/env bash

HOSTNAMES=(
    # Services
    database
    memcached

    # Sites
    advanced-embed.vanilla.localhost
    dev.vanilla.localhost
    embed.vanilla.localhost
    modern-embed.vanilla.localhost
    modern-embed-hub.vanilla.localhost
    vanilla.localhost
    sso.vanilla.localhost
    vanilla.test
    webpack.vanilla.localhost
);

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:";
    echo "sudo $0 $*";
    exit 1;
fi

DOCKER_CHECK=$(command -v docker);
if [ ! -n "$DOCKER_CHECK" ]; then
    echo "The docker command was not found. Make sure you installed Docker.";
    exit 1;
fi

CERTIFICATE_PATH1="./resources/certificates/wildcard.vanilla.localhost.crt";
if [ ! -f "$CERTIFICATE_PATH1" ]; then
    echo "Missing $CERTIFICATE_PATH1 certificate. Was it renamed or something?";
    exit 1;
fi

CERTIFICATE_PATH2="./resources/certificates/vanilla.localhost.crt";
if [ ! -f "$CERTIFICATE_PATH2" ]; then
    echo "Missing $CERTIFICATE_PATH2 certificate. Was it renamed or something?";
    exit 1;
fi

# Allows us to use database as the hostname to connect to the database.
for HOSTNAME in ${HOSTNAMES[@]}; do
    HOST_ENTRY=$(grep ^"$HOSTNAME" /etc/hosts);
    if [ ! -n "$HOST_ENTRY" ]; then
        echo '127.0.0.1 '"$HOSTNAME" \# Added from vanilla-docker/mac-setup.sh >> /etc/hosts
    fi
done

# https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-file-as-a-data-volume#creating-and-mounting-a-data-volume-container
DATA_STORAGE_CHECK=$(docker volume ls -q | grep datastorage);
if [ ! -n "$DATA_STORAGE_CHECK" ]; then
    docker volume create --name=datastorage --label="Persistent_data_storage" > /dev/null
fi

# Install our certificate for *.vanilla.localhost
CERTIFICATE_CHECK1=$(security find-certificate -c '*.vanilla.localhost' 2&> /dev/null);
if [ ! -n "$CERTIFICATE_CHECK1" ]; then
    security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERTIFICATE_PATH1";
fi

# Install our certificate for *.vanilla.localhost
CERTIFICATE_CHECK2=$(security find-certificate -c 'vanilla.localhost' 2&> /dev/null);
if [ ! -n "$CERTIFICATE_CHECK2" ]; then
    security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERTIFICATE_PATH2";
fi

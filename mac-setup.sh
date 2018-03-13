#!/usr/bin/env bash

HOSTNAMES=(
    advanced-embed.vanilla.localhost
    database
    dev.vanilla.localhost
    embed.vanilla.localhost
    memcached
    sso.vanilla.localhost
    vanilla.test
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

CERTIFICATE_PATH="./resources/certificates/vanilla.localhost.crt";
if [ ! -f "$CERTIFICATE_PATH" ]; then
    echo "Missing $CERTIFICATE_PATH certificate. Was it renamed or something?";
    exit 1;
fi

# Loopback 192.0.2.1 to our host (much like 127.0.0.1)
# See https://en.wikipedia.org/wiki/Reserved_IP_addresses#IPv4
# Same as "ifconfig lo0 alias 192.0.2.1" but permanent
LOOPBACK_FILE="/Library/LaunchDaemons/com.runlevel1.lo0.192.0.2.1.plist"
if [ ! -f "$LOOPBACK_FILE" ]; then
    cat > $LOOPBACK_FILE <<- EOM
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
      <key>Label</key>
      <string>com.runlevel1.lo0.192.0.2.1</string>
      <key>RunAtLoad</key>
      <true/>
      <key>ProgramArguments</key>
      <array>
          <string>/sbin/ifconfig</string>
          <string>lo0</string>
          <string>alias</string>
          <string>192.0.2.1</string>
      </array>
      <key>StandardErrorPath</key>
      <string>/var/log/loopback-alias.log</string>
      <key>StandardOutPath</key>
      <string>/var/log/loopback-alias.log</string>
  </dict>
</plist>
EOM
    chmod 0644 "$LOOPBACK_FILE"
    sudo chown root:wheel "$LOOPBACK_FILE"
    sudo launchctl load "$LOOPBACK_FILE"

fi

# Allows us to use database as the hostname to connect to the database.
for HOSTNAME in ${HOSTNAMES[@]}; do
    HOST_ENTRY=$(grep "$HOSTNAME" /etc/hosts);
    if [ ! -n "$HOST_ENTRY" ]; then
        echo '127.0.0.1 '"$HOSTNAME" \# Added from vanilla-docker/mac-setup.sh >> /etc/hosts
    fi
done

# https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-file-as-a-data-volume#creating-and-mounting-a-data-volume-container
DATA_STORAGE_CHECK=$(docker volume ls -q | grep datastorage);
if [ ! -n "$DATA_STORAGE_CHECK" ]; then
    docker volume create --name=datastorage --label="Persistent data storage" > /dev/null
fi

# Install our certificate for *.vanilla.localhost
CERTIFICATE_CHECK=$(security find-certificate -c '*.vanilla.localhost' 2&> /dev/null);
if [ ! -n "$CERTIFICATE_CHECK" ]; then
    security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERTIFICATE_PATH";
fi

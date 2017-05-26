#!/bin/bash

if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

HOSTNAMES=(database vanilla.dev sso.dev);

# Loopback 192.0.2.1 to our host (much like 127.0.0.1)
# See https://en.wikipedia.org/wiki/Reserved_IP_addresses#IPv4
# Same as "ifconfig lo0 alias 192.0.2.1" but permanent

FILE="/Library/LaunchDaemons/com.runlevel1.lo0.192.0.2.1.plist"
if [ ! -f "$FILE" ]; then
  cat > $FILE <<- EOM
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

chmod 0644 "$FILE"
sudo chown root:wheel "$FILE"
sudo launchctl load "$FILE"

fi

# Allows us to use database as the hostname to connect to the database.
for hostname in ${HOSTNAMES[@]}; do
    hostsentry=$(grep "$hostname" /etc/hosts)
    if [ ! -n "$hostsentry" ]; then
      echo '127.0.0.1 '"$hostname"
    fi
done

# https://docs.docker.com/engine/tutorials/dockervolumes/#mount-a-host-file-as-a-data-volume#creating-and-mounting-a-data-volume-container
docker volume create --name=datastorage --label="Persistent data storage"

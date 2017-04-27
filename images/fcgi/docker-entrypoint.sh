#!/bin/bash

configured=$(grep 'noreply@vanilla.dev' /etc/hosts)
if [ -n configured ]; then
  # add host to /etc/hosts
  host=$(hostname)
  line=$(cat /etc/hosts | grep $host)
  echo "$line noreply@vanilla.dev" >> /etc/hosts

  echo "$host" >> /etc/mail/relay-domains
  m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
fi

# Start sendmail
sendmail -bd

# Start php-fpm
php-fpm



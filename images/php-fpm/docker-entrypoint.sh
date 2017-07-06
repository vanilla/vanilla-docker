#!/bin/bash

configured=$(grep 'noreply@vanilla.dev' /etc/hosts)
if [ -z "$configured" ]; then
    # add host to /etc/hosts
    host=$(hostname)
    line=$(cat /etc/hosts | grep $host)
    echo "$line noreply@vanilla.dev" >> /etc/hosts

    echo "$host" >> /etc/mail/relay-domains

    # Make sure that sendmail does not error out if we spoof an email.
    #
    # This: www-data set sender to alexandre.c@vanillaforums.com using -f
    # Would result in an error:
    # (reason: 553 5.1.8 <alexandre.c@vanillaforums.com>... Domain of sender address alexandre.c@vanillaforums.com does not exist)
    #
    lineNumber=$(grep -n -m1 'dnl # Default Mailer setup' /etc/mail/sendmail.mc | cut -d ':' -f1)
    sed -i "${lineNumber}iFEATURE(\`accept_unresolvable_domains')dnl" /etc/mail/sendmail.mc
    sed -i "${lineNumber}idnl # Accept unresolvable domains" /etc/mail/sendmail.mc

    m4 /etc/mail/sendmail.mc > /etc/mail/sendmail.cf
fi

# Start sendmail
sendmail -bd

# Start php-fpm
php-fpm

FROM php:7.2-fpm-stretch

RUN set -xe; \
    apt-get update \
    && apt-get install -y \
        # for intl extension
        libicu-dev \
        # for gd
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        # memchached extension
        libmemcached-dev \
        # allow mailing to work
        sendmail \
        # Requirements for Blackfire installation.
        wget \
        gnupg \
    # pecl installs
    && pecl install xdebug \
    && pecl install memcached \
    # enable pecl installed extentions
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable memcached \
    # built in extensions install
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        gd \
        mbstring \
        pdo \
        pdo_mysql \
        intl \
    # Install Blackfire PHP extension.
    && wget -q -O - https://packagecloud.io/gpg.key | apt-key add - \
    && echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list \
    && apt-get update \
    && apt-get install blackfire-php \
    && docker-php-ext-enable blackfire \
    # cleanup
    && pecl clear-cache \
    && rm -rf \
        /var/lib/apt/lists/* \
        /usr/src/php/ext/* \
        /tmp/*

COPY ./usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./usr/local/etc/php/conf.d/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY ./usr/local/etc/php/conf.d/10-xdebug.ini /usr/local/etc/php/conf.d/10-xdebug.ini
COPY ./usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini /usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini
COPY ./usr/local/etc/php/conf.d/zzz-blackfire.ini /usr/local/etc/php/conf.d/zzz-blackfire.ini

RUN mkdir -p /shared/var/run/

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

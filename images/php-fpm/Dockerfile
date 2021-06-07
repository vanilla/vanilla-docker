FROM php:7.4-fpm-alpine

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN apk update \
    && apk add --no-cache \
        # build
        gcc make musl-dev php7-dev \
        # for intl extension
        icu \
        icu-dev \
        # for gd
        freetype libjpeg-turbo libpng libwebp libxpm \
        freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev libxpm-dev \
        # for mbstring
        oniguruma \
        oniguruma-dev \
        # memchached extension
        libmemcached \
        libmemcached-dev \
        # syslogd
        rsyslog \
        # iconv
        gnu-libiconv \
    # pecl installs
    && pecl install apcu \
    && pecl install memcached \
    && pecl install xdebug \
    # enable pecl installed extentions
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable opcache \
    && docker-php-ext-enable xdebug \
    # built in extensions install
    && docker-php-ext-configure gd \
        --enable-gd \
        --with-webp \
        --with-jpeg \
        --with-xpm \
        --with-freetype \
    && docker-php-ext-install -j$(nproc) \
        exif \
        gd \
        mbstring \
        pdo \
        pdo_mysql \
        intl \
    # cleanup
    && apk del \
        gcc make musl-dev php7-dev \
        icu-dev \
        freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev libxpm-dev \
        oniguruma-dev \
        libmemcached-dev \
    && pecl clear-cache
COPY ./conf/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
RUN touch /var/log/syslog

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

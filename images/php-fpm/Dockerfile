FROM php:7.4-fpm-alpine

RUN apk add --update --no-cache $PHPIZE_DEPS\
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
        freetype-dev libjpeg-turbo-dev libpng-dev libwebp-dev libxpm-dev \
        icu-dev\
        oniguruma-dev \
        libmemcached-dev \
    && pecl clear-cache
COPY ./conf/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf
RUN touch /var/log/syslog

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

CMD ["/docker-entrypoint.sh"]

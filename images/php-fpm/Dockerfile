FROM php:7.2-fpm-stretch

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpng-dev \
        sendmail \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mbstring pdo pdo_mysql zip \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install memcached \
    && docker-php-ext-enable memcached

# Install composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# Cleanup apt
RUN rm -rf /var/lib/apt/lists/*

COPY ./usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./usr/local/etc/php/conf.d/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY ./usr/local/etc/php/conf.d/10-xdebug.ini /usr/local/etc/php/conf.d/10-xdebug.ini
COPY ./usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini /usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini

RUN mkdir -p /shared/var/run/

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

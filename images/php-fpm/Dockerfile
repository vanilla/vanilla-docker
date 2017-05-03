FROM php:7.0-fpm

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpng12-dev \
        sendmail \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd mbstring mcrypt pdo pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

# Cleanup apt
RUN rm -rf /var/lib/apt/lists/*

COPY ./etc/php-fpm.conf /etc/php-fpm.conf
COPY ./etc/php/conf.d/00-php.ini /etc/php/conf.d/00-php.ini
COPY ./etc/php/conf.d/10-xdebug.ini /etc/php/conf.d/10-xdebug.ini
COPY ./etc/php/conf.d/vanilla-docker-sendmail.ini /etc/php/conf.d/vanilla-docker-sendmail.ini

RUN ln -s /srv/vanilla-repositories/vanilla /srv/htdocs

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

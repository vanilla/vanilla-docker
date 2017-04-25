FROM php:5.4-fpm
COPY usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY usr/local/etc/php/conf.d/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY usr/local/etc/php/conf.d/10-xdebug.ini /usr/local/etc/php/conf.d/10-xdebug.ini
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpng12-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd mbstring mcrypt pdo pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

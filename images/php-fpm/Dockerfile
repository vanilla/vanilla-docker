FROM php:7.2.6-fpm-stretch

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libpng-dev \
        sendmail \
        git python patchelf \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd mbstring pdo pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && rm -rf /var/lib/apt/lists/*

# Source repos do NOT have an up-to-date version of V8, so we need to build from source
RUN cd /tmp \
# Install depot_tools first (needed for source checkout)
    && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git \
    && export PATH=`pwd`/depot_tools:"$PATH" \
    # Download and Build v8 (pre-req to V8js)
    && fetch v8 \
    && cd v8 \
    # (optional) pin build a certain version instead of using bleeding-edge, @see https://omahaproxy.appspot.com/
    && git checkout 6.7.288.42 \
    && gclient sync \
    # Setup GN (build tool for V8)
    && tools/dev/v8gen.py -vv x64.release -- is_component_build=true \
    # Build
    && ninja -C out.gn/x64.release/ \
    # Install to /opt/v8/
    && mkdir -p /opt/v8/lib \
    && mkdir -p /opt/v8/include \
    && cp out.gn/x64.release/lib*.so out.gn/x64.release/*_blob.bin out.gn/x64.release/icudtl.dat /opt/v8/lib/ \
    && cp -R include/* /opt/v8/include/ \
    # Debian Stretch gotcha: set rpath so library folder can find files
    && for A in /opt/v8/lib/*.so; do patchelf --set-rpath '$ORIGIN' $A; done

# Get, Build & Install v8js (we need to build from source)
RUN cd /tmp \
    && git clone https://github.com/phpv8/v8js.git \
    && cd v8js \
    && phpize \
    && ./configure --with-v8js=/opt/v8 LDFLAGS="-lstdc++" \
    && make \
    #&& make test \
    && make install \
    && docker-php-ext-enable v8js

COPY ./usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf
COPY ./usr/local/etc/php/conf.d/00-php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY ./usr/local/etc/php/conf.d/10-xdebug.ini /usr/local/etc/php/conf.d/10-xdebug.ini
COPY ./usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini /usr/local/etc/php/conf.d/vanilla-docker-sendmail.ini

RUN mkdir -p /shared/var/run/

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]

FROM php:7.4.12-fpm-alpine

RUN apk add --no-cache icu-libs && \
    apk add --no-cache --virtual build-dependencies icu-dev && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    docker-php-ext-install -j${NPROC} intl && \
    docker-php-ext-install -j${NPROC} pdo_mysql && \
    apk del --no-cache --purge build-dependencies && \
    rm -rf /tmp/pear

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


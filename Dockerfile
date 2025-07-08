ARG PHP_VERSION=8.4

FROM php:${PHP_VERSION}-cli AS build

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

ARG PHP_EXTENSION=pgsql

RUN mkdir /data
RUN install-php-extensions "${PHP_EXTENSION}"
RUN export EXTENSION_DIR=$(php -r 'echo ini_get("extension_dir");') && \
    cp -v "${EXTENSION_DIR}/${PHP_EXTENSION}.so" /data


FROM scratch

COPY --from=build /data/* .

FROM php:7.1-cli

RUN apt-get update && \
    apt-get install -y \
    unzip \ 
    libzip-dev && \
    docker-php-ext-install zip

RUN groupadd -r app --gid=1000 && \
    useradd -r -g app --uid=1000 --home-dir=/usr/src/app --shell=/bin/bash app

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini" && \
    pecl config-set php_ini "$PHP_INI_DIR/php.ini"

COPY xdebug.ini /tmp
RUN pecl install xdebug-2.6.0 \
        && docker-php-ext-enable xdebug \
        && cat /tmp/xdebug.ini | grep -v '^#' >> "$PHP_INI_DIR/conf.d/docker-php-ext-xdebug.ini" \
        && rm /tmp/xdebug.ini

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer global require hirak/prestissimo

FROM php:8.2-fpm

RUN apt-get update && apt-get install -y libicu-dev libssl-dev \
    && docker-php-ext-install pdo pdo_mysql opcache \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

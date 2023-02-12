FROM php:8.1-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"
# Set working directory
WORKDIR /var/www

RUN apk add --update-cache \
    # required libraries
    && apk add libpq-dev libzip-dev \
    # Install nginx
    && apk add nginx \
    # Install required PHP extensions
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) mysqli \
    && apk add icu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Copy Php configuration
COPY configuration/php/php.ini /usr/local/etc/php/php.ini

# Copy php-fpm configuration
COPY configuration/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf

# Copy nginx configuration
COPY configuration/nginx/nginx.conf /etc/nginx/nginx.conf
COPY configuration/nginx/default /etc/nginx/sites-enabled/default

# Prepare container entrypoint
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

# Copy application files
COPY --chown=www-data:www-data ./application /var/www/html

# Available ports
EXPOSE 80

# Go!
ENTRYPOINT ["/etc/entrypoint.sh"]

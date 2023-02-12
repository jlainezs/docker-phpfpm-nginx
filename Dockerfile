FROM php:8.1-fpm

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y libpq-dev libzip-dev \
    && apt install -y nginx

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) mysqli \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev icu-devtools -y

# Copy Php configuration
COPY configuration/php/*.ini /usr/local/etc/php/conf.d

# Copy php-fpm configuration
COPY configuration/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf

# Copy nginx configuration
COPY configuration/nginx/nginx.conf /etc/nginx/nginx.conf
COPY configuration/nginx/default /etc/nginx/sites-enabled/default

# Prepare container entrypoint
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

# Copy application files
COPY --chown=www-data:www-data $WEBSITE /var/www/html

# Set working directory
WORKDIR /var/www/html/$WEBSITE

# Available ports
EXPOSE 80

# Go!
ENTRYPOINT ["/etc/entrypoint.sh"]

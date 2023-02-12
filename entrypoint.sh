#!/usr/bin/env bash
set -e

envsubst < /usr/local/etc/php/php.ini.tmp \
         > /usr/local/etc/php/conf.d/php.ini

php-fpm -D
nginx -g 'daemon off;'

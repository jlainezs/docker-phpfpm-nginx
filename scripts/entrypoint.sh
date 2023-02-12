#!/usr/bin/env ash

php-fpm -D
nginx -g 'daemon off;'

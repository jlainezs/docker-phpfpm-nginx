#!/usr/bin/env bash

# -------------------------------------
# build tool to produce the image
# -------------------------------------

# inject .env file if it exits
if [ -f .env ]; then
    set -a            
    source .env
    set +a
fi

mkdir -p tmp/configuration/nginx
mkdir -p tmp/configuration/php
mkdir -p tmp/configuration/php-fpm

envsubst < configuration/nginx/default \
            > tmp/configuration/nginx/default 
#cp configuration/nginx/default tmp/configuration/nginx/default
envsubst < configuration/nginx/nginx.conf \
            > tmp/configuration/nginx/nginx.conf 
envsubst < configuration/php/php-opcache-cfg.ini \
            > tmp/configuration/php/php-opcache-cfg.ini
envsubst < configuration/php/php.ini \
            > tmp/configuration/php/php.ini
envsubst < configuration/php-fpm/www.conf \
            > tmp/configuration/php-fpm/www.conf

docker build \
    --build-arg NGINX_PORT=$NGINX_PORT \
    -t $IMAGE_NAME . 

# rm -r tmp

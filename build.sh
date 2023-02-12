#!/usr/bin/env bash

# inject .env
if [ -f .env ]; then
    set -a            
    source .env
    set +a
fi

docker build -t $IMAGE_NAME .

#!/bin/sh
envsubst '${PORT}' < /etc/nginx/conf.d/default.conf > /tmp/nginx.conf
cp /tmp/nginx.conf /etc/nginx/conf.d/default.conf
php-fpm -D
nginx -g "daemon off;"

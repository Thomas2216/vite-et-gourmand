#!/bin/sh
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
php-fpm -D
sleep 2
nginx -g "daemon off;"

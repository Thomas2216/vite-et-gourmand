#!/bin/sh
echo "PORT is: $PORT"
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
echo "Nginx config:"
cat /etc/nginx/conf.d/default.conf
php-fpm -D
nginx -g "daemon off;"

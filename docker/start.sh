#!/bin/sh
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
php-fpm -D
nginx -g "daemon off;"
echo "=== NGINX STOPPED ==="

#!/bin/sh
echo "=== START SCRIPT ==="
echo "PORT: $PORT"
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
echo "=== NGINX CONFIG ==="
cat /etc/nginx/conf.d/default.conf
echo "=== TESTING NGINX ==="
nginx -t 2>&1
echo "=== STARTING PHP-FPM ==="
php-fpm -D
sleep 2
echo "=== STARTING NGINX ==="
nginx -g "daemon off;"

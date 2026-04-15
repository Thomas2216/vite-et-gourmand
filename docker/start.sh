#!/bin/sh
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
mkdir -p /var/www/html/var/cache/prod
mkdir -p /var/www/html/var/log
chmod -R 777 /var/www/html/var
php bin/console cache:warmup --env=prod 2>/dev/null || true
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

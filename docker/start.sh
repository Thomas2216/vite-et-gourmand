#!/bin/sh
mkdir -p /var/www/html/var/cache/prod/pools
mkdir -p /var/www/html/var/log
chmod -R 777 /var/www/html/var
chown -R www-data:www-data /var/www/html/var

envsubst '${PORT}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

php bin/console cache:warmup --env=prod 2>/dev/null || true
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

#!/bin/sh
sed -i "s/\${PORT}/$PORT/g" /etc/nginx/conf.d/default.conf
php bin/console cache:warmup --env=prod 2>/dev/null || true
exec supervisord -c /etc/supervisor/conf.d/supervisord.conf

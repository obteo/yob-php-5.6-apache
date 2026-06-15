#!/bin/bash

echo "=================================="
echo " XLRstats Web v3"
echo "=================================="

mkdir -p /home/container/public_html
mkdir -p /home/container/status
mkdir -p /home/container/logs

sed -i 's/^user = .*/user = container/' /etc/php/5.6/fpm/pool.d/www.conf
sed -i 's/^group = .*/group = container/' /etc/php/5.6/fpm/pool.d/www.conf
sed -i 's#listen = .*#listen = 127.0.0.1:9000#' /etc/php/5.6/fpm/pool.d/www.conf

php-fpm5.6 -D

exec nginx -g "daemon off;"

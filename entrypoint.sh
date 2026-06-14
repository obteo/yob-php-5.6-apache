#!/bin/bash

echo "=================================="
echo " XLRstats PHP 5.6 Web Container"
echo "=================================="

mkdir -p /home/container/public_html
mkdir -p /home/container/logs
mkdir -p /home/container/status

chown -R www-data:www-data /home/container

exec apachectl -D FOREGROUND
